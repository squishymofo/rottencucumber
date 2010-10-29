# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # before_filter :require_user, :except => [:developer_login]
  #layout 'application'
  helper :all # include all helpers, all the time
  protect_from_forgery

  #include SslRequirement
  helper_method :current_user

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def store_location
    #session[:return_to] = request.request_uri
    session[:return_to] = request.fullpath
  end

  def current_user
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      #redirect_to new_user_session_url
      redirect_to developer_login_path
      return false
    end
  end

end
