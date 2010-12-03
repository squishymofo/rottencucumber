class OrganizationsController < ApplicationController
  before_filter :current_user
  before_filter :require_user
  
  def new
    @org = Organization.new
  end

  def create
    #for now, creator_id is just one but this should be the id of the current user who is creating the organization.
    @org = Organization.new
    @org.name = params[:organization][:name]
    @org.description = params[:organization][:description]
    @org.creator_id = @current_user.id
    
    if @org.save
      @org.users << @current_user
      flash[:notice] = "#{params[:organization][:name]} has been created"
      redirect_to :action => :index
    else
      flash[:error] = "Failed creating a new organization"
      redirect_to :action => :new
    end
  end
  
  def index
    @joined_orgs = @current_user.organizations #organizations that the current user is a part of
    @my_orgs = Organization.where("creator_id = ?", @current_user.id) #organizations that the current user created
  end

  def show
    @org = Organization.find params[:id]
    
    if !@org.users.include?  @current_user
      redirect_to :controller => "organizations", :action => "index"
    end
    @creator = User.find @org.creator_id
    @projects = @org.projects
    @groups = @org.groups
  end
  
end
