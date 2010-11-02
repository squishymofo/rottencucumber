class UserSessionsController < ApplicationController
  before_filter :require_user, :except => [:developer_login, :create, :new]
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save do |result|
      if result
        redirect_to root_url
      else
        flash[:error] = "login incorrect"
        redirect_to root_url
      end
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    redirect_to root_url
  end

  def developer_login
    @user_session = UserSession.new
    render :layout => 'developer_login_layout'
  end

end
