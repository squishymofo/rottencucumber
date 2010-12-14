class Organization < ActiveRecord::Base
  has_many :user_organizations
  has_many :users, :through => :user_organizations
  has_many :projects, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  #has_many :tasks
  has_many :invitations, :dependent => :destroy
  belongs_to :creator, :class_name => 'User', :foreign_key => 'creator_id'
  validates_presence_of :name, :description
end
