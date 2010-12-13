Feature: Users increase their reputation by finishing tasks

	 Background:
		 Given that I am a registered and active user
		 And I am logged in

	@ok
	@javascript
	Scenario: When I finish a task my reputation should increase by the number of points assigned to that task
		Given I have "4" tasks assigned to me
		And I have "3" reputation
		And I am on the show page for the first task assigned to me
		And this task is worth "1" point
		When I follow "Finish"
		Then I should be on the show page for the first task assigned to me
		And I should see "Finished. Waiting for leader's approval"
		And I should have "4" reputation
		
	@ok
	@javascript
	Scenario: When someone else finishes a task assigned to me, my reputation should increase by the number of points assigned to the task
		Given I have "4" tasks assigned to me
		And I have "3" reputation
		When someone else finishes a task assigned to me worth "1" point
		Then I should have "4" reputation

	@ok
	@javascript
	Scenario: Users shouldn't be able to complete tasks that they're not assigned to, even if they're involved in the project
		Given there are "4" active tasks assigned to others in projects that I'm involved in
		And I'm looking at the show page for the first task for a project that I am involved in but not assigned to
		And this an active, unfinished task
		Then I should not see "Finish"
