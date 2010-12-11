Feature: users can subscribe to a task so that they get sent sms messages when new comments are made on that task.
	
	Background:
		Given that I am a registered and active user
		And I am logged in
	
	@ok
	Scenario: after users enable sms they're auto subscribed to tasks that they're assigned to
		Given I don't have sms enabled
		And I have "4" tasks assigned to me
		When I enable sms
		Then I should be subscribed to "4" tasks

	@ok
	Scenario: after a user disables sms they're auto unsubscribed from any tasks that they're subscibed to
		Given I have sms enabled
		And I have "4" tasks assigned to me
		And I have subscriptions to all of the tasks assigned to me
		When I disable sms
		Then I should be subscribed to "0" tasks

	@ok
	@javascript
	Scenario: users who don't have sms enabled can't subscribe to tasks
		Given I don't have sms enabled
		And I have "4" tasks assigned to me
		And I am on the show page for the first task assigned to me
		Then I should see "enable sms to subscribe"
		And I should not see "subscribe to comments"

	@ok
	@javascript
	Scenario: users who have sms enabled can unsubscribe from tasks that they're subscribed to
		Given I have sms enabled
		And I have "4" tasks assigned to me
		And I have subscriptions to all of the tasks that I'm assigned to
		And I am on the show page for the first task assigned to me
		And I follow "unsubscribe"
		Then I should be subscribed to "3" tasks
		And I should be on the show page for the first task assigned to me

	@ok
	@javascript
	Scenario: users with sms enabled can subscribe to tasks from projects they're involved in even if they aren't assigned to the task
		Given I have sms enabled
		And there are "4" active tasks assigned to others in projects that I'm involved in
		And I'm subscribed to 0 tasks
		And I'm looking at the show page for the first task for a project that I am involved in but not assigned to
		When I follow "subscribe to comments"
		Then I should be subscribed to the first task for for a project that I am involved in but not assigned to
		And I should be subscribed to the first task for for a project that I am involved in but not assigned to
		And I should see "unsubscribe"

	@ok
	@javascript
	Scenario: users with sms enabled can subscribe to tasks they're assigned to 
		Given I have sms enabled
		And I have "4" tasks assigned to me
		And I'm subscribed to 0 tasks
		And I am on the show page for the first task assigned to me
		When I follow "subscribe to comments"
		Then I should be subscribed to "1" tasks
		And I should be on the show page for the first task assigned to me
		And I should see "unsubscribe"

	@ok
	Scenario: users with sms enabled are not automattically subscribed to tasks from projects they're involved in but not assigned to
		Given I have sms enabled
		And I have no comment subscriptions
		When "4" new active get tasks assigned to others in projects that I'm involved in but not to me
		Then I shouldn't be suscribed to any tasks that I'm not involved in

	@ok
	Scenario: users with sms enabled can not subscribe to tasks from projects they're not involved in
		Given I have sms enabled
		And I attempt to subscribe to a task from a project that I'm not involved in
		Then I shouldn't have any task subscriptions
