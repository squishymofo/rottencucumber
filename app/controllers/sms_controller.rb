class SmsController < ApplicationController
  before_filter :require_user, :except => [:inbound_sms]
  def inbound_sms
    
    from_phone_number = params[:From].scan(/[0-9]+/).first[1..100]
    @user = User.find_by_phone_number from_phone_number
    @sms_processor = SmsProcessor.new(SmsSession.get_sms_session(@user.phone_number), params[:Body])
    @sms_processor.process_message
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    unless @sms_processor.response_message.empty?
      logger.info(@sms_processor.response_message)
      h = {:From => PHONE_NUMBER, :To => from_phone_number, :Body => @sms_processor.response_message}
      resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', h)
      # TODO: what if the api fails? need to inspect the resp and address this case
    end
    render :nothing => true
  end

  def outbound_sms
  end

end
