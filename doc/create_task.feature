Feature: Create a task
	As a team leader
	I want to be able to create a task

	Background:
		Given I'm logged in as a leader
	Scenario: see a form
		When I click the “create a task” button
		Then I can see a form about that task
	Scenario: fill out the form
		Given I’m in the form page
		When I fill out every necessary field on the form
		And I click the “next” button
		Then a task is created
		And I can see the task being added to my task list
