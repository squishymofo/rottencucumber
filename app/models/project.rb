class Project < ActiveRecord::Base
  has_many :tasks
  belongs_to :organization
  validates_presence_of :name, :description
end
