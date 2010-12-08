Feature: enable SMS capabilities.
	
	@javascript
	Scenario: a user successfully enables SMS capabilities
		Given I am on the home page
		Given I am a logged in user who hasn't yet enabled SMS capabilities
		When I follow "enable SMS"
		And I check "user_sms_enabled"
		And I fill in "user_phone_number" with "440-554-8235"
		And I press "Save"
		Then I should have SMS enabled
		And my phone number should be "4405548235"
		And I should be on the user preferences page

	@javascript
	Scenario: A user attempts to enable SMS with a phone number that isn't exactly 7 digits
		Given I am a logged in user who hasn't yet enabled SMS capabilities
		And I am on the home page
		And I follow "enable SMS"
		And I check "user_sms_enabled"
		And I fill in "user_phone_number" with "123"
		And I press "Save"
		Then I should not have SMS enabled
		And my phone number should not be saved
		And I should see "Phone number should be exactly 10 "

	@javascript
	Scenario: A user attempts to enable SMS with a phone number that belongs to another user
		Given there is a user who has enabled SMS capabilities with phone number "2169269443"
		Given I am a logged in user who hasn't yet enabled SMS capabilities
		And I am on the home page
		And I follow "enable SMS"
		And I check "user_sms_enabled"
		And I fill in "user_phone_number" with "2169269443"
		And I press "Save"
		Then I should not have SMS enabled
		And my phone number should not be saved
		And I should see "phone number needs to be unique"

	@javascript
	Scenario: a user who has already enabled SMS capabilities can change their phone number 
		Given I am a logged in user who has enabled SMS capabilities with phone number "2169269443"
		When I go to the user preferences page
		And I fill in "user_phone_number" with "4405548235"
		And I press "Save"
		Then my phone number should be "4405548235"
		And my phone number should not be "2169269443"
		And I should be on the user preferences page
