require 'spec_helper'

describe SmsSession do
    before(:each) do
      @valid_attributes = {
        :phone_number = "4405548235",
      }
    end

    it "should not allow an sms_session without a valid phone_number "
      SmsSession.create(
    end

    it "should expire after 10 hours"
      SmsSession.create(
    end

    after(:each) do
      User.all.each {|u| u.destroy}
    end

end
