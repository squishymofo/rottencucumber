require 'spec_helper'

describe SmsSession do
    before(:each) do
      @valid_attributes = {
        :phone_number => "4405548235"
      }
    end

    it "should not allow an sms_session without a valid phone_number" do
      SmsSession.new( :phone_number => "2343").should_not be_valid
    end

    it "should not allow an sms_session with phone_number belonging to a user with SMS disabled" do
      user = make_active_user_with_sms_disabled
      SmsSession.new(:phone_number => user.phone_number).should_not be_valid
    end

    it "should expire after 10 hours" do
      #TODO
    end

    after(:each) do
      User.all.each {|u| u.destroy}
    end

end

def make_active_user_with_sms_disabled
    u = User.new(:email => "spitfire67@berkeley.edu", :password => "password", :password_confirmation => "password", :first_name => "James")
    u.first_name = "James"
    u.active = true
    u.save(false)
    u.active = true
    u.save
    assert u.active
    u.phone_number = "4405548235"
    u.sms_enabled = false
    u.save
    u
end

