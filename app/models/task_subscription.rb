class TaskSubscription < ActiveRecord::Base
  require 'lib/user_involved_in_task_project_validator'
  belongs_to :user
  belongs_to :task
  validates :user_id, :user_involved_in_task_project => true
  def self.get_subscription(user, task)
    # might need to pass this a hash
    TaskSubscription.where(:user_id => user.id, :task_id => task.id).first
  end

  def already_subscribed?
    self.id != nil
  end
end
