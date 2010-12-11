Feature: users can subscribe to a task so that they get sent sms messages when new comments are made on that task.
	
	Background:
		Given that I am a registered and active user
		And I am logged in
	
	@javascript
	Scenario: after users enable sms they're auto subscribed to tasks that they're assigned to
		Given I don't have sms enabled
		And I have "4" active tasks assigned to me
		When I enable sms
		Then I should be subscribed to "4" tasks

	Scenario: users who don't have sms enabled can't subscribe to tasks
		Given I don't have sms enabled
		And I have "4" active tasks assigned to me
		And I am on the show page for the first task assigned to me
		Then I should see "enable sms to subscribe"
		And I should not see "subscribe to comments"

	Scenario: users with sms enabled are not automattically subscribed to tasks from projects they're involved in but not assigned to
		Given I have sms enabled
		And I have no comment subscriptions
		When "4" new active get tasks assigned to others in projects that I'm involved in but not to me
		Then I shouldn't have any comment subscriptions

	Scenario: users with sms enabled can subscribe to tasks from projects they're involved in but not assigned to 
		Given I have sms enabled
		And there are "4" active tasks assigned to others in projects that I'm involved in
		And I'm looking at the show page for the first task for a project that I am involved in but not assigned to
		When I follow "subscribe to comments"
		Then I should be scribed to the first task for for a project that I am involved in but not assigned to

	Scenario: users with sms enabled can subscribe to tasks they're assigned to
		Given I don't have sms enabled
		And I have "4" active tasks assigned to me
		And I am on the show page for the first task assigned to me
		When I follow "subscribe to comments"

	Scenario: users with sms enabled can not subscribe to tasks from projects they're not involved in
