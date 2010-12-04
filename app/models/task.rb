class Task < ActiveRecord::Base
  #belongs_to :organization
  belongs_to :group
  belongs_to :project
end
