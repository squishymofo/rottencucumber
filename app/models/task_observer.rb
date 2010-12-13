class TaskObserver < ActiveRecord::Observer

  def after_create(task)
    # for each user assinged to the task with sms enabled
    task.group.users.where(:sms_enabled => true).each do |user|
      sms_session = SmsSession.get_sms_session(user.phone_number)
      #we could change the sms_session task context here..
      SmsProcessor.deliver_new_task_notification(sms_session, task) unless Rails.env == "test"
    end
  end

  def after_update(task)
    unless task.changed_attributes["status"] == nil
      # if status was changed to finished (from any state)
      if task.status == 2
        task.group.users.each {|u| increase_user_reputation(u, task.point)}
      end
    end
  end


  def increase_user_reputation(user, points)
    user.reputation = user.reputation + points
    user.save
  end

end
