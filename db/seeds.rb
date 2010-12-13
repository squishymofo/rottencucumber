# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
#   Create me
def make_active_user_with_sms_enabled(email, first_name, phone_number)
  u = User.new(:email => email, :password => "password", :password_confirmation => "password", :first_name => first_name)
  u.first_name = first_name
  u.active = true
  u.save(:validate => false)
  u.active = true
  u.save(:validate => false)
  u.phone_number = phone_number
  u.sms_enabled = true
  u.save
  u
end

def make_active_user_without_sms_enabled(email, first_name)
  u = User.new(:email => email, :password => "password", :password_confirmation => "password", :first_name => first_name)
  u.first_name = first_name
  u.active = true
  u.save(:validate => false)
  u.active = true
  u.save(:validate => false)
  u
end

def make_group_for_users(users_a)
  g = Group.create!(:name => "test_group")
  users_a.each do |user|
    user.groups << g
    user.save(:validate => false)
  end
  g
end

def make_task_for_group(group, task_name, proj)
  Task.create(:group_id => group.id, :name => task_name, :status => 1, :description => "the desc", :project_id => proj)
end

@user = make_active_user_with_sms_enabled("spitfire67@berkeley.edu", "James", "4405548235")
@user2 = make_active_user_without_sms_enabled("someone@example.com", "Jared")
@org = Organization.create(:name => "my org", :description => "desc of my org") # create an org
@user.organizations << @org # this is my org
@user.save
@g = make_group_for_users([@user, @user2])
@p = Project.create(:name => "do work", :organization_id => @org.id, :description => "description")
@t = make_task_for_group(@org, "Clean up the back porch", @p)
@t = make_task_for_group(@org, "Buy rubber tubing", @p)
