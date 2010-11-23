class SmsController < ApplicationController
  before_filter :require_user, :except => [:inbound_sms]
  def inbound_sms
    
    from_phone_number = params[:From].scan(/[0-9]+/).first[1..100]
    @user = User.find_by_phone_number from_phone_number
    @sms_processor = SmsProcessor.new(SmsSession.get_sms_session(@user.phone_number), params[:Body])
    @sms_processor.process_message
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    logger.info(@sms_processor.response_message)
    h = {:From => "510-550-5285", :To => from_phone_number, :Body => @sms_processor.response_message}
    logger.info ("Sending body #{h[:Body]}")
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', h)
    render :nothing => true
  end

  def outbound_sms
  end

end
