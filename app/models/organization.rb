class Organization < ActiveRecord::Base
  has_many :user_organizations
  has_many :users, :through => :user_organizations
  has_many :projects
  
  validates_presence_of :name, :description
end
