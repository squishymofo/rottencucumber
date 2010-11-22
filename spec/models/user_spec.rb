require 'spec_helper'

describe User do
  before(:each) do 
    @valid_attributes = {
      :first_name => "James",
      :last_name => "Butkovic",
      :email => "spitfire67@berkeley.edu",
      :password => "password1",
      :password_confirmation => "password1"
    }
  end

  after(:each) do 
  end

  it "should not allow enabled SMS without a valid phone number" do
    user = User.create(@valid_attributes)
    user.phone_number = "123"
    user.sms_enabled = true
    user.should_not be_valid
  end

  it "should allow a user without a phone number" do
    user = User.new(@valid_attributes)
    user.should be_valid
  end


end
