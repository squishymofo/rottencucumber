
Given /^I'm logged in as a leader$/ do
    pending # express the regexp above with the code you wish you had
end

Given /^there is a user with email "([^"]*)"$/ do |arg1|
    !User.where(:email => arg1).nil? || User.create!(:email => arg1, :password => "password", :password_confirmation => "password")
end

Given /^that a user with email "([^"]*)" and password "([^"]*)" and first name "([^"]*)" exists and is valid$/ do |email, password, first_name|
    u = User.create!(:email => email, :password => "password", :password_confirmation => "password", :first_name => first_name)
    u.first_name = first_name
    u.save
    u.active = true
    u.save
    assert u.active
end

Given /^that a new user with email "([^"]*)" has been created and sent an email confirmation email$/ do |arg1|
  u = User.new
  u.signup!({:email => arg1})
  u.reset_perishable_token!
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

