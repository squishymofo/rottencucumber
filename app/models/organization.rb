class Organization < ActiveRecord::Base
  has_many :user_organizations
  has_many :users, :through => :user_organizations
  has_many :projects
  has_many :groups
  has_many :tasks
  has_many :invitations
  validates_presence_of :name, :description
end
