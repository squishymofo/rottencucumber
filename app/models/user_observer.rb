class UserObserver < ActiveRecord::Observer
  def after_update(user)
    unless user.changed_attributes["sms_enabled"] == nil
      if user.changed_attributes["sms_enabled"] == false
        # delete all subscriptions
        task_subs = TaskSubscription.find_by_user_id(user.id)
        task_subs.each {|t| t.delete} if task_subs
      else # was changed to true
        # create subscriptions to all tasks assigned to
        user.tasks.each {|t| t.task_subscriptions.create(:user_id => user.id)}
      end
    end
  end
end
