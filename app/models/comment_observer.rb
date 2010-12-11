class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    #send subscribers sms messages
  end
end
