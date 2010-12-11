class SmsController < ApplicationController
  before_filter :require_user, :except => [:inbound_sms]
  def inbound_sms
    
    from_phone_number = params[:From].scan(/[0-9]+/).first[1..100]
    @user = User.find_by_phone_number from_phone_number
    sms_session = SmsSession.get_sms_session @user.phone_number
    Rails.logger.info(sms_session.to_yaml)
    @sms_processor = SmsProcessor.new sms_session, params[:Body]
    @sms_processor.process_message
    resp = @sms_processor.send_response 
    #resp wil be nil if no response
    render :nothing => true
  end

  def outbound_sms
  end

end
