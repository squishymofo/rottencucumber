Feature: create a group
	As a team leader
	I want to be able to create a group
	Background:
		Given I’m logged in as a leader

	Scenario: see a list
		And I’m in the group managing page
		When I click the “create a group” button
		Then I should see a list of my members

	Scenario: add members to a group
		And I’m in the member list page
		When I select an arbitrary number of group members
		And I click the “next” button
		Then a group is created with the selected group members
		And I should see it in my group list
