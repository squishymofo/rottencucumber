class Comment < ActiveRecord::Base
  require 'lib/user_involved_in_task_project_validator'
  validates :body, :presence => true
  validates :user_id, :presence => true, :user_involved_in_task_project => true
  validates :task_id, :presence => true
  belongs_to :user
  belongs_to :task
end
