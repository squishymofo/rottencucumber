class TaskObserver < ActiveRecord::Observer

  def after_create(task)
    # for each user assinged to the task with sms enabled
    task.group.users.where(:sms_enabled => true).each do |user|
      sms_session = SmsSession.get_sms_session(user.phone_number)
      #we could change the sms_session task context here..
      SmsProcessor.deliver_new_task_notification(sms_session, task) unless Rails.env == "test"
      create_subscription(user, task)
    end
  end

  def after_update(task)
    unless task.changed_attributes["status"] == nil
      # if status was changed to finished (from any state)
      if task.status == 2
        task.group.users.each {|u| increase_user_reputation(u, task.point)}
        task.subscribed_users.each {|u| send_sms_task_completion_notification(u, task) unless u.id == task.finished_by_id}
      end
    end
  end

  def create_subscription(user, task)
    TaskSubscription.create(:user_id => user.id, :task_id => task.id)
  end

  def send_sms_task_completion_notification(user, task)
    body = get_task_completion_notification_body(task.finished_by, task.name)
    resp = ""
    task.subscribed_users.each do |u|
      account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
      h = {:From => PHONE_NUMBER, :To => u.phone_number, :Body => body}
      resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', h)
    end
    resp
    #send task name and task.finished_by.first_name
  end

  def get_task_completion_notification_body(completed_by, task_name)
    return "#{task_name} was just finished by #{completed_by.first_name}"
  end


  def increase_user_reputation(user, points)
    user.reputation = user.reputation + points
    user.save
  end

end
