class OrganizationsController < ApplicationController
  before_filter :current_user
  def new
    @org = Organization.new
  end

  def create
    #for now, creator_id is just one but this should be the id of the current user who is creating the organization.
    @org = Organization.new
    @org.name = params[:organization][:name]
    @org.description = params[:organization][:description]
    if @current_user != nil
      @org.creator_id = @current_user.id
    else
      @org.creator_id = 4
    end
    
    if @org.save
      flash[:notice] = "#{params[:organization][:name]} has been created"
      redirect_to :action => :index
    else
      flash[:error] = "Failed creating a new organization"
      redirect_to :action => :new
    end
  end

  def index
    if @current_user != nil
      @id = @current_user.id
      @joined_orgs = @current_user.organizations #organizations that the current user is a part of
    else
      @id = 4
      @joined_orgs = []
    end
      
    @my_orgs = Organization.find_by_creator_id(@id.id) #organizations that the current user created


  end

  def show
    @org = Organization.find(params[:id])
  end
end
