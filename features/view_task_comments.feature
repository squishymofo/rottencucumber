Feature: view task comments

	Background:
                Given that I am a registered and active user
                And I have "4" tasks assigned to me
		And I am logged in

	@ok
	@javascript
	Scenario: a user views a task that has comments and can see the comments
		Given that I am on the show page for a task assigned to me that has comments "hello"
		Then I should see "hello"
		And I should not see "There aren't any comments yet"

	@ok
	@javascript
	Scenario: a user views a task with no comments shouldn't see any comments
		Given that I am on the show page for a task assigned to me that doesn't have any comments
		Then I should see "There aren't any comments yet"
