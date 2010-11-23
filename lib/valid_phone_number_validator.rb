class ValidPhoneNumberValidator < ActiveModel::EachValidator  
  def validate_each(object, attribute, value)  
    if value
      phone_number = value.scan(/\d+/).join.to_s
      unless phone_number.size == 10
        object.errors[attribute] << (options[:message] || "should be exactly 10 digits")
      end
      if User.find_by_phone_number(phone_number)
        object.errors[attribute] << (options[:message] || "phone number needs to be unique")
      end
    end
  end
end 
