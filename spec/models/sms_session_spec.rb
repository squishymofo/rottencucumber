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

    it "should expire after 10 hours" do
      #TODO
    end

    after(:each) do
      User.all.each {|u| u.destroy}
    end

end
