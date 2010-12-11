class UserObserver < ActiveRecord::Observer
  def after_update(user)
    unless user.changed_attributes["sms_enabled"] == nil
      if user.changed_attributes["sms_enabled"] == false
        # delete all subscriptions
        user.task_subscriptions.each {|s| s.delete}
      else # was changed to true
        # create subscriptions to all tasks assigned to
        user.tasks.each {|t| t.task_subscriptions.create(:user_id => user.id)}
      end
    end
  end
end
