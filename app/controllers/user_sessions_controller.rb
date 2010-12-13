class UserSessionsController < ApplicationController
  before_filter :require_user, :except => [:demo_login, :create, :new]
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

  def demo_login
    @user_session = UserSession.new(:email => "spitfire67@berkeley.edu", :password => "password")
    @user_session.save
    current_user
    redirect_to root_url
  end


end
