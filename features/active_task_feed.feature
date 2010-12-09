Feature: a feed of the active tasks from projects that you're involved in
	  We'll keep completed tasks for the tasks index.	

	Background:
		Given that I am a registered and active user
		And I have "4" tasks assigned to me
		And there are "4" active tasks assigned to others in projects that I'm involved in
	
	@javascript
	Scenario: User visits the landing page and sees the active tasks assigned to them
		Given I am logged in
		When I go to the home page
		Then I should see the active tasks that are assigned to me

	@javascript
	Scenario: User visits the landing page and sees the active tasks for projects that the user is involved in, but not assigned to
		Given I am logged in
		When I go to the home page
		Then I should see the active tasks that for the project that I'm involved in but not assigned to

	@javascript
	Scenario: User with completed tasks visits the landing page and does not see the inactive completed tasks assigned to them
		Given I am logged in
		And I have completed a task "Thing 1 assigned to me"
		When I go to the home page
		Then I should see the active tasks that are assigned to me
		And I should not see "Thing 1 assigned to me"
