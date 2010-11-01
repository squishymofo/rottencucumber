class OrganizationsController < ApplicationController
  before_filter :current_user
  
  
  def new
    @organization = Organization.new
  end

  def create
    #for now, creator_id is just one but this should be the id of the current user who is creating the organization.
    @organization = Organization.new
    @organization.name = params[:organization][:name]
    @organization.description = params[:organization][:description]
    @organization.creator_id = @current_user.id
    
    if @organization.save
      flash[:notice] = "#{params[:organization][:name]} has been created"
      redirect_to :action => :index
    else
      flash[:error] = "Failed creating a new organization"
      redirect_to :action => :new
    end
  end

  def index
    @my_orgs = Organization.find_by_creator_id(@current_user.id) #organizations that the current user created
    #organizations that the current user is a part of
  end

  def show
    
  end
end
