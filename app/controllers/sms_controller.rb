class SmsController < ApplicationController
  before_filter :require_user, :except => [:inbound_sms]
  def inbound_sms
    @user = User.find_by_phone_number(params[:From].scan(/\d+/).join.to_s)
    message_body = params[:Body].strip
    @sms_processor = SmsProcessor.new(UserSession.find_by_phone_number(@user.phone_number), message_body)
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    h = {:From => "415-599-2671", :To => n, :Body => @sms_processor.resonse_message}
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', h)
    render :nothing => true
  end

  def outbound_sms
  end

end
