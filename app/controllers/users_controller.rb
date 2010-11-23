class UsersController < ApplicationController

  def new
    @user = User.new
    render :layout => false
  end

  def create
    @user = User.new(params[:user])
    oath = params[:oauth_provider] || params[:code] || params[:oauth_token]
    if oath
      @user.save do |result|
        if result
          if @user.access_token.type == "FacebookToken"
            @user.signup_with_facebook 
            @user.deliver_activation_confirmation!
            UserSession.create(@user)
          elsif @user.access_token.type == "TwitterToken"
            profile = JSON.parse(@user.access_token.get("/me"))
            @user.email = profile["email"]
          end
          current_user
          redirect_to root_url(:check_email => 1)
        else
        end
      end
    else
      if @user.signup!(params)
        @user.deliver_activation_instructions!
        @check_email = true
        redirect_to root_url(:check_email => 1)
      else
        @signup_problems = true
        render :template => 'landing/index' # should show errors here and redirect them to the 
      end
    end
  end

  def edit
    @user = @current_user
  end

  def create_new_user # for admin / testing
    @user = User.create!(params[:user])
    @user.active = true
    @user.save(false)
    @user.first_name = params[:user][:first_name]
    @user.last_name = params[:user][:last_name]
    @user.admin = true if params[:user][:admin] == 1
    @user.save(false)
    redirect_to edit_user_path(:other_user_id => @user.id)
  end

  def update
    if params[:user][:sms_enabled] == "1"
      @current_user.sms_enabled = true
    end
    if params[:user][:sms_enabled] == "0"
      @current_user.sms_enabled = false
    end
    @current_user.phone_number = params[:user][:phone_number]
    @current_user.save
    if @current_user.errors.any?
      @user = @current_user
      render :edit
    else
      redirect_to edit_user_path(@current_user)
    end
  end

end
