Feature: new user registration
	
	@javascript
	Scenario: save the (inactive) user and send a registration confirmation email when the user enters a valid email
		Given I am on the home page
		When I press "Become a member"
		And I fill in "email" with "someone@example.com"
		And I press "Sign up"
		Then there should be an inactive user with email "someone@example.com"
		And a confirmation email should be sent to "someone@example.com"
		And I should see "please check your email for activation instructions."

	@javascript
	Scenario: # a registration confirmation email does not get sent with an invalid email and displays error
		Given I am on the home page
		When I press "Become a member"
		And I fill in "email" with "asflkj"
		And I press "Sign up"
		Then I should see "Email is invalid"
		And there shouldn't be any user with email "asflkj"

	@javascript
	Scenario: # no two users can have the same email address
		Given I am on the home page
		And there is a user with email "someone@example.com"
		When I press "Become a member"
		And I fill in "email" with "someone@example.com"
		And I press "Sign up"
		Then I should see "Email has already been taken"
	
	@javascript
	Scenario: Account activation
		Given that a new user with email "spitfire67@berkeley.edu" has been created and sent an email confirmation email
		When I go to the finish registration page for user with email "spitfire67@berkeley.edu"
		And I fill in "password" with "password"
		And I fill in "password_confirmation" with "password"
		And I press "Big save button"
		Then user with email "spitfire67@berkeley.edu" should be activated
