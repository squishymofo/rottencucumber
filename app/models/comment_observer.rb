class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    #send subscribers sms messages
    #comment.subscribed_users.each {|u| u.send_comment_over_sms(comment.body)}
  end
end
