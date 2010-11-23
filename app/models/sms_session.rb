class SmsSession < ActiveRecord::Base
  require 'lib/valid_phone_number_validator'
  validates :phone_number, :valid_phone_number => true
  def user
    User.find_by_phone_number phone_number
  end

  def active?
    ((Time.now - Time.parse(updated_at.to_s)).to_i / 60) < SMS_SESSION_VALID_FOR
  end

end
