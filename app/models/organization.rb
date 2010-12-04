class Organization < ActiveRecord::Base
  has_many :user_organizations
  has_many :users, :through => :user_organizations
  has_many :projects, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  #has_many :tasks
  has_many :invitations, :dependent => :destroy
  validates_presence_of :name, :description
end
