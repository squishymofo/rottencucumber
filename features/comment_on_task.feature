Feature: Comment on task

	Background:
	        Given that I am a registered and active user
		And I am logged in
	
	@javascript
	Scenario: A user successfully comments on an assigned task
                Given I have "4" tasks assigned to me	
		And I am on the show page for the first task assigned to me
		When I fill in "comment_body" with "This is my comment"
		And I press "Comment!"
		Then I should be on the show page for the first task assigned to me 
		And I should see "This is my comment"

	@javascript
	Scenario: A user attempts to comment on an assigned task but leaves the body blank
                Given I have "4" tasks assigned to me	
		And I am on the show page for the first task assigned to me
		When I don't fill the body field of the comment
		When I press "Comment!"
		Then I should see "can't be blank"

	@javascript
	Scenario: A user who is not assigned to a task but is involved in the project that the task belongs to successfully comments on the task
		Given there are "4" active tasks assigned to others in projects that I'm involved in
		And I'm looking at the show page for the first task for a project that I am involved in but not assigned to 
		When I fill in "comment_body" with "This is my comment"
		And I press "Comment!"
		Then I should see my comment
