class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users, :through => :user_groups
  has_many :tasks
  belongs_to :organization
end
