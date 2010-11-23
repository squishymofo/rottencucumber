class GroupsController < ApplicationController
  before_filter :current_user
  before_filter :require_user
  
  def index
    @groups = Group.find(:all)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @joined_orgs = @current_user.organizations 
    #organizations that the current user is a part of
  end

  def create
    #debugger
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

end
