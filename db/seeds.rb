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
@user2 = make_active_user_without_sms_enabled("someone@example.com", "Long")
@user3 = make_active_user_with_sms_enabled("someone1@example.com", "DiDi", "3108183518")
@user4 = make_active_user_with_sms_enabled("someone2@example.com", "Dennis", "6266071565")
@org = Organization.create(:name => "RottenCucumber", :description => "cs 169 group", :creator_id => @user.id) # create an org
User.all.each do |u| 
  u.organizations << @org
  u.save
end 
@g = make_group_for_users([@user, @user2])
@p = Project.create(:name => "Taho ski trip", :organization_id => @org.id, :description => "Let's go skiiing guys")
@p = Project.create(:name => "Cucumber cultivation", :organization_id => @org.id, :description => "It is our nature")
