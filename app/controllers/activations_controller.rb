class ActivationsController < ApplicationController

  def new
    current_navigation :welcome
    if params[:activation_code]
      @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
      raise Exception if @user.active?
    end
    @confirming_new_user = true
    render :template => 'landing/index'
  end

  def create
    @user = User.find(params[:id])
    raise Exception if @user.active?
    if @user.activate!(params)
      #year, month, day
      @user.first_name = params[:first_name]
      @user.last_name = params[:last_name]
      @user.save
      @user.deliver_activation_confirmation!
      @thank_user = true
      current_user
      render :template => 'landing/index'
    else
      render :action => :new
    end
  end

end
