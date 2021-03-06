class SmsSession < ActiveRecord::Base
  require 'lib/valid_phone_number_validator'
  require 'lib/sms_enabled_validator'
  validates :phone_number, :valid_phone_number => true, :sms_enabled => true, :on => :create
  def user
    User.find_by_phone_number phone_number
  end

  def active?
  ((Time.now - Time.parse(updated_at.to_s)).to_i / 60) < SMS_SESSION_VALID_FOR
  end

  def self.get_sms_session(phone_number)
    existing_sess = SmsSession.find_by_phone_number phone_number
    unless existing_sess
      existing_sess = SmsSession.create(:phone_number => phone_number)
    end
    existing_sess
  end

end
