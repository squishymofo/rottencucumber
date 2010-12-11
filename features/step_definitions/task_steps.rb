Given /^I have subscriptions to all of the tasks assigned to me$/ do
  #find all tasks and create subscritions
  u = User.find_by_email("spitfire67@berkeley.edu")
  u.tasks.each do |t|
    s = t.task_subscriptions.create(:user_id => u.id)
    assert s.user
    assert s.task
  end
  assert u.task_subscriptions.size == u.tasks.size
end


Given /^that I am on the show page for a task assigned to me that has comments "([^"]*)"$/ do |comment_body|
  u = User.first
  t = User.first.active_tasks.first
  assert t
  t.comments.create(:body => comment_body, :user_id => u.id, :task_id => t.id)
  Given "I am on the show page for task with id \"#{t.id}\""
end

Given /^that I am on the show page for a task assigned to me that doesn't have any comments$/ do
  u = User.first
  t = User.first.active_tasks.first
  assert t
  Given "I am on the show page for task with id \"#{t.id}\""
end

When /^I don't fill the body field of the comment$/ do
end

Then /^I should be subscribed to "([^"]*)" tasks$/ do |arg1|
  u = User.find_by_email("spitfire67@berkeley.edu")
  u.task_subscriptions.size == arg1.to_i
end

Then /^I should be subscribed to the first task for for a project that I am involved in but not assigned to$/ do
  u = User.find_by_email("spitfire67@berkeley.edu")
  s = TaskSubscription.first
  t = s.task
  assert s.user_id = u.id
  assert u.tasks_from_projects_involved_in.include?(t)
  assert !u.tasks.include?(t)
end

Given /^I'm subscribed to (\d+) tasks$/ do |arg1|
  Then "I should be subscribed to \"#{arg1}\" tasks"
end

Then /^I should debug$/ do
  debugger
end

Given /^I have no comment subscriptions$/ do
  assert User.find_by_email("spitfire67@berkeley.edu").task_subscriptions.empty?
end

When /^"([^"]*)" new active get tasks assigned to others in projects that I'm involved in but not to me$/ do |arg1|
  When "there are \"4\" active tasks assigned to others in projects that I'm involved in"
end

Then /^I shouldn't be suscribed to any tasks that I'm not involved in$/ do
  u = User.find_by_email("spitfire67@berkeley.edu")
  assert u
  assert (u.task_subscriptions.size == 1) || (u.task_subscriptions.size == 0)
end


Then /^I shouldn't have any task subscriptions$/ do
  u = User.find_by_email("spitfire67@berkeley.edu")
  assert u
  assert u.task_subscriptions.empty?
end

Given /^I attempt to subscribe to a task from a project that I'm not involved in$/ do

  me = User.first
  # create another user
  other = create_registered_and_active_user("someone@example.com", "password", "Jared")
  org = Organization.first
  unless org
    org = Organization.create(:name => "my org", :description => "org desc..")
  end
  me.organizations << org # this is my org
  me.save
  g = Group.create(:name => "test groups", :organization_id => org.id)
  UserGroup.create(:user_id => other.id, :group_id => g.id) # add the other to the group
  # find the project of me
  p = Project.first
  unless p
    p = Project.create(:name => "do work", :organization_id => org.id, :description => "description") # create a project to add some tasks to
  end
  
  t = Task.create(:name => "Thing someone else is responsable for", :description => "Description of task that I don't care about", :group_id => g.id, :project_id => p.id, :status => 1)
  s = TaskSubscription.create(:user_id => me.id, :task_id => t.id)
  assert s.errors.any?
end



Given /^I'm looking at the show page for the first task for a project that I am involved in but not assigned to$/ do
  # id = TODO
  # need to create a task that I'm assigned to
  this_t = Task.first
  id = this_t.id
  p = this_t.project
  org = p.organization
  u = User.find_by_email("spitfire67@berkeley.edu")
  g = Group.create(:name => "test groups", :organization_id => org.id)
  UserGroup.create(:user_id => u.id, :group_id => g.id) # add the me to the group
  old_t = Task.create(:name => "Thing assigned to me", :description => "Description of task ", :group_id => g.id, :project_id => p.id, :status => 1)

  Given "I am on the show page for task with id \"#{id}\""
end


Given /^I have subscriptions to all of the tasks that I'm assigned to$/ do
  u = User.find_by_email("spitfire67@berkeley.edu")
  assert u
  u.tasks.each {|t| TaskSubscription.create(:user_id => u.id, :task_id => t.id)}
  assert u.task_subscriptions.size == u.tasks.size
end
Given /^I have "([^"]*)" tasks assigned to me$/ do |num_tasks|
  u = User.first
  org = Organization.create(:name => "my org", :description => "desc of my org") # create an org
  u.organizations << org # this is my org
  u.save
  g = Group.create(:name => "test groups", :organization_id => org.id)
  UserGroup.create(:user_id => u.id, :group_id => g.id) # add the me to the group
  p = Project.create(:name => "do work", :organization_id => org.id, :description => "description") # create a project to add some tasks to
  (1..num_tasks.to_i).each do |i| #now add some active tasks to the project
      Task.create(:name => "Thing #{i} assigned to me", :description => "Description of task #{i}", :group_id => g.id, :project_id => p.id, :status => 1)
  end

end

Given /^there are "([^"]*)" active tasks assigned to others in projects that I'm involved in$/ do |num_tasks|
  me = User.first
  # create another user
  other = create_registered_and_active_user("someone@example.com", "password", "Jared")
  org = Organization.first
  unless org
    org = Organization.create(:name => "my org", :description => "org desc..")
  end
  me.organizations << org # this is my org
  me.save
  g = Group.create(:name => "test groups", :organization_id => org.id)
  UserGroup.create(:user_id => other.id, :group_id => g.id) # add the other to the group
  # find the project of me
  p = Project.first
  unless p
    p = Project.create(:name => "do work", :organization_id => org.id, :description => "description") # create a project to add some tasks to
  end
  
  (1..num_tasks.to_i).each do |i| #now add some tasks to the project
      Task.create(:name => "Thing #{i} someone else is responsable for", :description => "Description of task #{i} that I don't care about", :group_id => g.id, :project_id => p.id, :status => 1)
  end
end

Then /^I should see my comment$/ do
  #Then "I should see \"\""
  Then /^I should see \"hello"\$/
end


def create_registered_and_active_user(email, password, first_name)
  u = User.new(:email => email, :password => "password", :password_confirmation => "password", :first_name => first_name)
  u.first_name = first_name
  u.active = true
  u.save(:validate => false)
  u.active = true
  u.save
  u
end
