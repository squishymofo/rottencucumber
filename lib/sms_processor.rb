class SmsProcessor
  attr_accessor :incoming_message_body, :sms_session, :excess, :response_message, :reply_options, :task_context
  def initialize(sms_session, incoming_message_body)
    @incoming_message_body = incoming_message_body
    @sms_session = sms_session
    @active_session = @sms_session.active?
    @user = @sms_session.user
  end

  #should get whole response, then store extra in more
  def process_message
    message_a = @incoming_message_body.split
    cmd = message_a.first.downcase
    Rails.logger.info("here 5")
    case cmd
    when /tasks/
      @response_message = process_tasks_msg
    when /^[0-9]+$/ #TODO: should return the description along with menu AND also set task context
      @response_message = process_describe_msg(cmd)
      set_task_context(cmd)
    when /describe/
      @response_message = process_describe_msg(message_a[1]) #TODO: EDIT: if no number in message_a[1], should look for context and describe that task
      set_task_context(message_a[1])
    when /more/ # note: untested
      @response_message = process_more_msg
    #when /^say [0-9]+ .*$/ # dennis: please fix, happens when user texts in 'say comment_body' while in a task context
    when /^say/
      comment_body = message_a.values_at(1..(message_a.size)).join(" ").rstrip
      @response_message = process_comment_msg(comment_body)
    #when //
    #when /complete/
    #when /notes/ #get the comments (assumes a task context)
    else
      @response_message = process_help_msg
    end
    save_excess if @excess
  end

  def process_more_msg
    "more stuff.."
  end

  def process_help_msg
    if @sms_session.task_id && @sms_session.active?
      tasks_help_menu
    else
      general_help_menu
    end
  end

  def general_help_menu
    return "Text 'tasks' to view active tasks assigned to you."
  end

  def tasks_help_menu
    return "task help menu"
  end

  def list_tasks_instructions(full_response_size)
    instructions = "reply with the task number for a description"
    if full_response_size + instructions.size > SMS_MAX_LENGTH 
      @needs_more = true
      instructions += " or more for more"
    end
    instructions
  end

  def process_tasks_msg #populates the @response_message a numbered list of tasks assigned to the user
    full_response = ""
    @user.active_tasks.each {|task| full_response += "#{task.id}. #{task.name}\n"}
    list_tasks_instructions = list_tasks_instructions(full_response.size)
    if @needs_more
      full_response = list_tasks_instructions + full_response[0..(SMS_MAX_LENGTH - list_tasks_instructions.size - 3)] + "..."
      @excess = full_response[(SMS_MAX_LENGTH - list_tasks_instructions.size - 3)..full_response.size]
    else
      full_response = full_response + list_tasks_instructions
    end
  end

  def shorten_message(full_response, instructions)
  end

  def save_excess
    @sms_session.more = @excess
    @sms_session.save
  end

  def process_describe_msg(task_number) # should set the task context to the 
    #TODO: need to make sure that the task belongs to the user
    description = Task.find(task_number).description
    if description
      @response_message = description
    else
      @response_message = "This task doesn't have a description"
    end
  end

  def process_comment_msg(comment_body)
    # TODO: need to check for the different kinds of messages
    task_id = @sms_session.task_id
    if task_id
      task = Task.find(task_id)
      if task
        puts("here 2")
        comment = Comment.new(:body => comment_body, :task_id => task.id, :user_id => @user.id )
        if comment.save
          @response_message = ""
        else
          @response_message = general_help_menu
        end
      else
        @response_message = general_help_menu
      end
    else
    puts("here 3")
      @response_message = general_help_menu
    end
  end

  def set_task_context(task_id)
    @sms_session.task_id = task_id
    @sms_session.save
  end

end
