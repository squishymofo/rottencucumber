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
  end

  def new
    @group = Group.new
    @my_orgs = Organization.where("creator_id = ?", @current_user.id)
    @joined_orgs = @current_user.organizations
  end

  def create
    @group = Group.new
    @group.name = params[:group_name]
    @group.organization_id = params[:selected_org]    
    if @group.save
      flash[:notice] = "The group #{params[:group_name]} has been created and assigned to organization #{params[:selected_org]}"
      redirect_to :action => :index
    else
      flash[:error] = "Failed creating a new group"
      redirect_to :action => :new
    end
  end

  def show
    
  end

end
