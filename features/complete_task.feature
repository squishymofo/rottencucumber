Feature: assertion of completion
	As a group member
	I want to be able to tell a leader that I have completed a task

	Scenario: assertion of completion
		Given I’m logged in as a group member
		And I’m in the task progress page for a specific task
		When I click the “I’m done!” button
		Then I should see a notification page saying that the task completion is waiting for the leader’s approval
