class GroupsController < ApplicationController
  before_filter :current_user
  
  def index
    @groups = Group.find(:all)
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
    @joined_orgs = @current_user.organizations #organizations that the current user is a part of
  end

  def create
    @group = Group.new
    @group.name = params[:group][:name]
    @group.organization_id = params[:group][:selected_org]    
    if @group.save
      flash[:notice] = "#{params[:group][:name]} has been created"
      redirect_to :action => :index
    else
      flash[:error] = "Failed creating a new group"
      redirect_to :action => :new
    end
  end

end
