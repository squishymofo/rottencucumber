Feature: user login

	@javascript
	Scenario: user login with valid creds
		Given that a user with email "spitfire67@berkeley.edu" and password "password" and first name "James" exists and is valid
		And I am on the home page
		When I press "I am a member"
		And I fill in "user_session_email" with "spitfire67@berkeley.edu" 
		And I fill in "user_session_password" with "password" 
		And I press "Sign in"
		Then I should see "James"

	@javascript
	Scenario: user login with valid creds
		Given I am on the home page
		When I press "I am a member"
		And I fill in "user_session_email" with "spitfire67@berkeley.edu" 
		And I fill in "user_session_password" with "password" 
		And I press "Sign in"
		Then I should see "Hello unrecognized user"
