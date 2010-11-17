# Before do
#   $organization = Organization.new
#   $current_user = User.new
# end
# 
# Given /^I am logged in as an organization leader with id ([0-9]*)$/ do |id|  
#   $current_user.id = id  
#   $current_user.save
# end
# 
# And /^I have an organization with id ([0-9]*)$/ do |id|
#   $organization.id = id
#   $organization.name = "Test Organization"
#   $organization.description = "Test Organization"
#   $organization.creator_id = $current_user.id
# end
# 
# When /^I visit the project creation page$/ do
#   @current_user = $current_user
#   visit "/projects/new/#{$organization.id}"
# end
# Given /^I have logged out$/ do
#   visit '/logout'
# end

And /^I fill in my password and login$/ do
  puts page.to_s
  within("#new_user_session") do
    fill_in 'user_session_email', :with => 'varlain@hotmail.com'
    fill_in 'user_session_password', :with => 'Monkeypatch'
  end
end
