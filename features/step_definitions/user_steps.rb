
Given /^I am a logged in user who hasn't yet enabled SMS capabilities$/ do
    Given "that a user with email \"spitfire67@berkeley.edu\" and password \"password\" and first name \"James\" exists and is valid"
    Given "I am a logged in user"
end

Given /^that a user with email "([^"]*)" and password "([^"]*)" and first name "([^"]*)" exists and is valid/ do |email, password, first_name|
    u = User.new(:email => email, :password => "password", :password_confirmation => "password", :first_name => first_name)
    u.first_name = first_name
    u.active = true
    u.save(false)
    u.active = true
    u.save
    assert u.active
end

Given /^I am a logged in user who has enabled SMS capabilities with phone number "([^"]*)"$/ do |phone_number|
    Given "that a user with email \"spitfire67@berkeley.edu\" and password \"password\" and first name \"James\" exists and is valid"
    Given "I am a logged in user"
    u = User.find_by_email "spitfire67@berkeley.edu"
    u.phone_number = phone_number
    u.sms_enabled = true
    u.save
end

Given /^there is a user who has enabled SMS capabilities with phone number "([^"]*)"$/ do |phone_number|
    Given "that a user with email \"someone@example.com\" and password \"password\" and first name \"Jeanine\" exists and is valid"
    u = User.find_by_email "someone@example.com"
    u.phone_number = phone_number
    u.sms_enabled = true
    u.save
end

Given /^I'm logged in as a leader$/ do

    pending # express the regexp above with the code you wish you had
end

Given /^there is a user with email "([^"]*)"$/ do |arg1|
    User.create!(:email => arg1, :password => "password", :password_confirmation => "password")
end

Given /^I am a logged in user$/ do
    Given "that a user with email \"spitfire67@berkeley.edu\" and password \"password\" and first name \"James\" exists and is valid"
    And "I am on the home page"
    When "I press \"I am a member\""
    And "I fill in \"user_session_email\" with \"spitfire67@berkeley.edu\""
    And "I fill in \"user_session_password\" with \"password\""
    And "I press \"Sign in\""
    Then "I should see \"James\""
end


Given /^that a new user with email "([^"]*)" has been created and sent an email confirmation email$/ do |arg1|
  u = User.new
  u.signup!({:email => arg1})
  u.reset_perishable_token!
end

When /^I complete the login form with valid username and password$/ do

end

Then /^there should be an inactive user with email "([^"]*)"$/ do |arg1|
    u = User.find_by_email(arg1)
    assert u
    assert !u.active
end

Then /^a confirmation email should be sent to "([^"]*)"$/ do |arg1|
    assert !ActionMailer::Base.deliveries.empty?
end

Then /^there shouldn't be any user with email "([^"]*)"$/ do |arg1|
    assert !User.find_by_email(arg1)
end

Then /^user with email "([^"]*)" should be activated$/ do |arg1|
    assert User.find_by_email(arg1).active
end


Then /^I should have SMS enabled$/ do
    assert User.find_by_email("spitfire67@berkeley.edu").sms_enabled
end

Then /^my phone number should be "([^"]*)"$/ do |arg1|
    User.last.phone_number == arg1
end

Then /^I should not have SMS enabled$/ do
    assert !User.last.sms_enabled
end

Then /^my phone number should not be saved$/ do
    assert !User.last.phone_number
end

Then /^my phone number should not be "([^"]*)"$/ do |arg1|
      !(User.last.phone_number == arg1)
end

