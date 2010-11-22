Feature: view tasks over SMS

	Background: 
		Given I am a logged in user who has enabled SMS capabilities with phone number "2169269443"
		And I have "4" active tasks assigned to me

	@wip
	Scenario: User texts "tasks" to get a numbered of active tasks assigned to the user
		And I have no sms session
		When I text in "tasks"
		Then I should be texted a numbered list of names of active tasks that are assigned to me
	
	@wip
	Scenario: User who has previously texted "tasks" texts in a task number to get the task description
		And I have texted in "tasks"
		When I text in "1"
		Then I should be texted a description of task "1" assigned to be
