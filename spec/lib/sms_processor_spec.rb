require 'spec_helper'


describe SmsProcessor do
  #TODO: it should not allow a phone number of a user who doesn't have sms enabled
  before(:each) do 
    @sms_session = SmsSession.create(:phone_number => "4405548235")
    @user = make_active_user_with_sms_enabled
  end

  after(:each) do 
    SmsSession.all.each {|s| s.delete}
    User.all.each {|u| u.destroy}
  end

  it "should respond with a numbered list of the user's active tasks when texted 'tasks'" do
    g = make_group_for_user(@user)
    make_task_for_group(g, "task 1")
    @sms_processor = SmsProcessor.new(@sms_session, "tasks")
    @sms_processor.process_message
    #"1. task 1\nreply with the task number for a description or more for more"
    assert @sms_processor.response_message == ("1. task 1\n" + @sms_processor.list_tasks_instructions(@sms_processor.response_message.size))
  end

  it "should respond with the general help menu when texted 'help' when no task context" do
    g = make_group_for_user(@user)
    @sms_processor = SmsProcessor.new(@sms_session, "help")
    @sms_processor.process_message
    #"1. task 1\nreply with the task number for a description or more for more"
    assert @sms_processor.response_message == @sms_processor.general_help_menu
  end

  it "should respond with task specific help menu when texted 'help' while in a task context" do
    g = make_group_for_user(@user)
    t = make_task_for_group(g, "task 1")
    @sms_session.task_id = t.id
    @sms_session.save
    @sms_processor = SmsProcessor.new(@sms_session, "help")
    @sms_processor.process_message
    #"1. task 1\nreply with the task number for a description or more for more"
    assert @sms_processor.response_message == @sms_processor.tasks_help_menu
  end

  it "should switch task context when texted a task number" do
    g = make_group_for_user(@user)
    t = make_task_for_group(g, "help")
    @sms_processor = SmsProcessor.new(@sms_session, t.id.to_s)
    @sms_processor.process_message
    assert @sms_session.task_id == t.id
  end

end

def make_active_user_with_sms_enabled
  u = User.new(:email => "spitfire67@berkeley.edu", :password => "password", :password_confirmation => "password", :first_name => "James")
  u.first_name = "James"
  u.active = true
  u.save(false)
  u.active = true
  u.save
  assert u.active
  u.phone_number = "4405548235"
  u.sms_enabled = true
  u.save
  u
end

def make_group_for_user(user)
  g = Group.create!
  user.groups << g
  user.save(false)
  g
end

def make_task_for_group(group, task_name)
  Task.create(:group_id => group.id, :name => task_name)
end
