# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
#   Create me
def make_active_user_with_sms_enabled
  u = User.new(:email => "spitfire67@berkeley.edu", :password => "password", :password_confirmation => "password", :first_name => "James")
  u.first_name = "James"
  u.active = true
  u.save(:validate => false)
  u.active = true
  u.save
  u.phone_number = "4405548235"
  u.sms_enabled = true
  u.save
  u
end

def make_group_for_user(user)
  g = Group.create!(:name => "test_group")
  user.groups << g
  user.save(:validate => false)
  g
end

def make_task_for_group(group, task_name)
  Task.create(:group_id => group.id, :name => task_name, :status => 1, :description => "the desc")
end

@user = make_active_user_with_sms_enabled
@org = Organization.create(:name => "my org", :description => "desc of my org") # create an org
@user.organizations << @org # this is my org
@user.save
@g = make_group_for_user(@user)
@t = make_task_for_group(@org, "task 1")
@p = Project.create(:name => "do work", :organization_id => @org.id, :description => "description")
@t.project_id = @p.id
@t.save

