Feature: Marking Task Completion As A Leader
	In order to keep track of progress
	As an organization leader
	I want to be able to create a project
	I want to also be able to add task to a newly created project
	
	@javascript
	Scenario: Project Creation
		Given I am on the homepage
		When I press "I am a member"
		And I fill in my password and login
		And I press "Sign in"
		And I fillin "user_session_email" with "spitfire67@berkeley.edu"
		And I fill in "user_session_password" with "password"
		And I press "Sign in"
		And I go to the project creation page
		And I fill in "name" with "Grow More Cucumbers"
		And I fill in "description" with "All of our cucumbers are rotten"
		And I press "Create Task"
		Then I should see "Grow More Cucumbers"
		
		
		
		
