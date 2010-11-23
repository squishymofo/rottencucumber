class SmsEnabledValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)  
    if value
      user = User.find_by_phone_number(value)
      if user
        if !user.sms_enabled
          object.errors[attribute] << (options[:message] || "should be contain a number of a user who has SMS enabled")
        end
      end
=begin
      phone_number = value.scan(/\d+/).join.to_s
      unless phone_number.size == 10
        object.errors[attribute] << (options[:message] || "should be exactly 10 digits")
      end
      if object.class == User
        if User.find_by_phone_number(phone_number)
          object.errors[attribute] << (options[:message] || "phone number needs to be unique")
        end
      elsif object.class == SmsSession
        if SmsSession.find_by_phone_number(phone_number)
          object.errors[attribute] << (options[:message] || "phone number needs to be unique")
        end
      end
=end
    end
  end
end 
