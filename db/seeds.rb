# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
#   Create me
u = User.new(:email => "spitfire67@berkeley.edu", :password => "password", :password_confirmation => "password", :first_name => "James")
u.first_name = "James"
u.active = true
u.save(false)
u.active = true
u.save
u.phone_number = "4405548235"
u.sms_enabled = true
u.save
org = Organization.create(:name => "my org", :description => "desc of my org", :creator_id => u.id) # create an org
u.organizations << org # this is my org
u.save
g = Group.create(:name => "test groups", :organization_id => org.id) # create a group within the org
UserGroup.create(:user_id => User.find_by_phone_number("4405548235").id, :group_id => g.id) # add the me to the group
p = Project.create(:name => "do work", :organization_id => org.id, :description => "description") # create a project to add some tasks to
num_tasks = "2"
(1..num_tasks.to_i).each do |i| #now add some tasks to the project
  Task.create(:name => "Thing #{i}", :description => "Description of task #{i}", :group_id => g.id, :project_id => p.id, :status => 0)
end
