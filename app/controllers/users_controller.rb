class UsersController < ApplicationController

  def new
    @user = User.new
    render :layout => false
  end

  def create
    @user = User.new(params[:user])
    if (params[:oauth_provider] || params[:code] || params[:oauth_token])
      @user.save do |result|
        if result
          if @user.access_token.type == "FacebookToken"
            profile = JSON.parse(@user.access_token.get("/me"))
            @user.email = profile["email"]
            @user.first_name = profile["first_name"]
            @user.last_name = profile["last_name"]
            @user.active = true
            @user.deliver_activation_confirmation!
            @user.save
            UserSession.create(@user)
          elsif @user.access_token.type == "TwitterToken"
            profile = JSON.parse(@user.access_token.get("/me"))
            @user.email = profile["email"]
          end
          current_user
          @thank_user = true
          redirect_to root_url(:check_email => 1)
        else
        end
      end
    else
      if @user.signup!(params)
        @user.deliver_activation_instructions!
        redirect_to root_url(:check_email => 1)
      else
        redirect_to root_url
      end
    end
  end

  def edit
    unless params[:other_user_id]
      if @current_user.admin
        @new_user = User.new
      end
      @user = @current_user
    end
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
    @current_user.first_name = params[:user][:first_name]
    @current_user.last_name = params[:user][:last_name]
    @current_user.save(false)
    redirect_to edit_user_path @current_user
  end

end
