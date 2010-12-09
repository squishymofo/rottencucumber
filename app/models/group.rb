class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users, :through => :user_groups
  has_many :tasks
  belongs_to :organization
  
  validates_presence_of :name, :on => :create, :message => "can't be blank"
  def first_names_of_people
    users.map(&:first_name)
  end
end
