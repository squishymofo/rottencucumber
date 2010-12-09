class Comment < ActiveRecord::Base
  validates :body, :presence => true
  validates :user_id, :presence => true
  validates :task_id, :presence => true
  belongs_to :user
  belongs_to :task
end
