class SmsSession < ActiveRecord::Base
  require 'lib/valid_phone_number_validator'
  require 'lib/sms_enabled_validator'
  validates :phone_number, :valid_phone_number => true, :sms_enabled => true
  def user
    User.find_by_phone_number phone_number
  end

  def self.get_sms_session(phone_number)
    existing_sess = SmsSession.find_by_phone_number phone_number
    existing_sess
  end

end
