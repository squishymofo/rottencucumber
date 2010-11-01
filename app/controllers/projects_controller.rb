class ProjectsController < ApplicationController
  before_filter :current_user
  
  def index
    org_id = params[:org_id]
    @projects = Project.find_by_organization_id(org_id)
  end

  def new
    @project = Project.new
    @org = Organization.find(params[:org_id])
    @groups = @org.groups
  end

  def show
    
  end

  def create
    
  end
  
  def manage
    
  end

end
