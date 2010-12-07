class ProjectsController < ApplicationController
  before_filter :current_user
  
  def index
    set_of_projs = Set.new
    @current_user.groups.each do |g|
      g.tasks.each do |t|
        set_of_projs.add(t.project)
      end
    end
    @projects = set_of_projs.to_a
  end

  def new
    @org = Organization.find(params[:org_id])
    
    if @org.creator_id == @current_user.id #only allows the creator of this organization to create a new project
      @project = Project.new
      @groups = @org.groups
    else
      render 'projects/access_denied'
    end
  end

  def create  
    @org_id = params[:org][:id]
    @project = Project.new
    @project.name = params[:project][:name]
    @project.description = params[:project][:description]
    @project.organization_id = @org_id
    
    if @project.save
      flash[:notice] = "#{params[:project][:name]} has been created"
      redirect_to "/organizations/#{@org_id}" 
    else
      flash[:error] = "Failed creating a new project"
      redirect_to "/projects/new/#{@org_id}"
    end
    
  end
  
  def show
    @project = Project.find(params[:id])
    if !@current_user.organizations.include? @project.organization
      #user is not in the organization that owns this project, user should not be able to see the project
      redirect_to :controller => "projects", :action => "index"
    else
      @org = @project.organization
      @tasks = @project.tasks
    end
  end
  
  # def manage
  #   @task = Task.new
  #   @id = params[:id]
  #   @project = Project.find(@id)
  #   @org = @project.organization
  #   @groups = @org.groups
  #   
  #   if @org.creator_id == @current_user.id #only allows the creator of this organization to create a new project
  #     if params[:commit]
  #       @task = Task.new
  #       @task.name = params[:task][:name]
  #       @task.description = params[:task][:description]
  #       @task.point = params[:point]
  #       @task.due = Date.new(params[:start_date][:year].to_i, params[:start_date][:month].to_i , params[:start_date][:day].to_i)
  #       @task.organization_id = @org.id
  #       @task.project_id = @id
  #       if @task.save
  #         params[:task] = nil
  #         flash[:notice] = "Task successfully created"
  #       else
  #         flash[:error] = "Failed to create new task"
  #       end
  #     end
  #     
  #     @tasks = @project.tasks
  #   else
  #     render 'projects/access_denied'
  #   end
  # end
end
