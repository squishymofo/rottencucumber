class GroupsController < ApplicationController
  before_filter :current_user
  before_filter :require_user
  
  def index
    @users_in_groups_with_me = @current_user.get_users_in_groups_with_me
    @tasks_assigned_to_me = @current_user.active_tasks
    @groups = Group.find(:all)
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users
  end

  def new
    @group = Group.new
    if params[:id] == nil   # should not be able to create a new group unless it's thru org
      flash[:error] = "Error creating new group"
      render "/projects/access_denied"
    else
      @org = Organization.find(params[:id])
      @users = @org.users
    end
  end

  def create
    @group = Group.new
    @group.name = params[:name]
    @group.organization_id = params[:organization][:id]
    
    if @group.save
      params[:members].each do |member| 
        unless member.to_i == -1
          @user = User.find(member)
          if !@group.users.include? @user
            @group.users <<  @user
          end
        end
      end  
      flash[:notice] = "The group #{params[:name]} has been created"
      redirect_to "/organizations/show/#{params[:organization][:id]}"
    else
      flash[:error] = "Failed creating a new group"
      redirect_to "/groups/new/#{params[:organization][:id]}"
    end
  end

end
