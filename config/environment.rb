# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Rottencucumber::Application.initialize!
require 'sms_processor'
require 'lib/valid_phone_number_validator'

SMS_MAX_LENGTH = 120
SMS_SESSION_VALID_FOR = (60 * 10)
ACCOUNT_SID = "AC52fc1041c155b69f58405fb45f6cd302"
ACCOUNT_TOKEN = "e6f56af66592e58730d23dcb33a97d1b"
API_VERSION = "2008-08-01"
APP_PHONE_NUMBER = "4155992671"
