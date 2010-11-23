Given /^I have "([^"]*)" active tasks assigned to me$/ do |arg1|
  org = Organization.create(:name => "my org") # create an org
  g = Group.create(:name => "test groups", :organization_id => org.id) # create a group within the org
  UserGroup.create(:user_id => User.find_by_phone_number("4405548235").id, :group_id => g.id) # add the me to the group
  p = Project.create(:name => "do work", :organization_id => org.id) # create a project to add some tasks to
  (1..arg1.to_i).each do |i| #now add some tasks to the project
    Task.create!(:name => "Thing #{i}", :description => "Description of task #{i}", :group_id => g.id, :project_id => p.id, :status => 0)
  end
end

Given /^I have no sms session$/ do
  assert !SmsSession.find_by_phone_number("4405548235")
end

When /^I text in "([^"]*)"$/ do |inbound_sms_message|
  sms_session = SmsSession.create(:phone_number => "4405548235")
  @sms_processor = SmsProcessor.new(sms_session, inbound_sms_message)
  @sms_processor.process_message
end

When /^I subsequently text in "([^"]*)"$/ do |inbound_sms_message|
  sms_session = SmsSession.where(:phone_number => "4405548235")
  @sms_processor = SmsProcessor.new(sms_session, inbound_sms_message)
  @sms_processor.process_message
end

Then /^I should be texted a numbered list of names of active tasks that are assigned to me$/ do
  assert @sms_processor.response_message.split("1.").size > 1
end

Given /^I have texted in "([^"]*)"$/ do |arg1|
  When "I text in \"#{arg1}\""
end

Then /^I should be texted a description of task "([^"]*)"$/ do |arg1|
  assert @sms_processor.response_message.split("Description")[1] != nil
end
