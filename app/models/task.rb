class Task < ActiveRecord::Base
  #belongs_to :organization
  belongs_to :group
  belongs_to :project
  has_many :comments
  has_many :task_subscriptions
  has_many :subscribed_users, :through => :task_subscriptions, :source => :user

  def translate_status
    case self.status
    when 0
      "Not yet started"
    when 1
      "Started"
    when 2
      "On Halt"
    when 3
      "Finished"
    else
      raise Exception
    end
  end

  def can_user_access?(user)
    user.tasks_from_projects_involved_in.map(&:id).include?(self.id)
  end


end
