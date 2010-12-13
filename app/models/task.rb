class Task < ActiveRecord::Base
  #belongs_to :organization
  belongs_to :group
  belongs_to :project
  belongs_to :finished_by, :class_name => 'User', :foreign_key => 'finished_by_id'
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

  def finish!(user)
    self.finished_by_id = user.id
    self.status = 2
    self.save
  end

  def can_user_access?(user)
    user.tasks_from_projects_involved_in.map(&:id).include?(self.id)
  end

  def latest_comment
    comments.order('created_at desc').first
  end

  def recent_comments
    comments.order('created_at desc').limit(4)
  end

  def get_comments_after(after)
    if after == "undefined"
      comments
    else
      comments.where("created_at > ?", Time.at(after.to_i + 1))
    end
  end

  def lastest_comment_created_at_if_any
    lc = latest_comment
    if lc
      lc.created_at.to_i.to_s
    else
      ""
    end
  end

end
