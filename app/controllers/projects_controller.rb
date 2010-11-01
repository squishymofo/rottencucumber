class ProjectsController < ApplicationController
  before_filter :current_user
  
  def index
    @org_id = params[:org_id]
    @projects = Project.where(["organization_id = ?", @org_id])
    puts @projects
  end

  def new
    @org = Organization.find(params[:org_id])
    
    if @org.creator_id == @current_user.id 
      @project = Project.new
      @groups = @org.groups
    else
      render 'projects/access_denied'
    end
  end

  def show
    
  end

  def create
    puts "IS THIS THING WORKING"
    @org_id = params[:org][:id]
    @project = Project.new
    @project.name = params[:project][:name]
    @project.description = params[:project][:description]
    @project.organization_id = @org_id
    
    if @project.save
      puts "-----------------Saving project-------------------"
      flash[:notice] = "#{params[:project][:name]} has been created"
      redirect_to "projects/#{@org_id}"
    else
      puts "-----------------Failed saving project-------------------"
      flash[:error] = "Failed creating a new project"
      redirect_to :action => :new
    end
    
  end
  
  def manage
    @id = params[:id]
    @project = Project.find(@id)
    @groups = @project.groups
    @tasks = @project.tasks
  end

end
