class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    #send subscribers sms messages
    comment.task.subscribed_users.each {|u| send_comment_over_sms(u, comment.body)}
  end

  def send_comment_over_sms(u, body)
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    h = {:From => PHONE_NUMBER, :To => u.phone_number, :Body => body}
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', h)
    resp
  end
      
end
