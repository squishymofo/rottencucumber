Feature: Marking Task Completion As A Leader
	In order to keep track of progress
	As an organization leader
	I want to be able to create a project
	I want to also be able to add task to a newly created project
	
	@javascript
	Scenario: Organization Creation
		Given that a user with email "varlain@hotmail.com" and password "Monkeypatch" and first name "Dennis" exists and is valid
		And I am on the home page
		When I press "I am a member"
		And I fill in "user_session_email" with "varlain@hotmail.com"
		And I fill in "user_session_password" with "Monkeypatch" 
		And I press "Sign in"
		When I go to the organization creation page
		And I fill in "organization_name" with "Organization Test"
		And I fill in "organization_description" with "Organization Test"
		And an organization will be created
		
		
		
		
