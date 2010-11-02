Feature: manage tasks
	As a team leader
	I want to be able to see information about all my tasks

	Background:
		Given I’m logged in as a leader

	Scenario: view tasks
		When I click the “manage tasks” button
		Then I should see all my tasks

	Scenario: see information about one particular task
		And I’m on the tasks list page
		When I click on a specific task
		Then I should see another page with all the information about that task
