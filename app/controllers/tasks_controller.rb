class TasksController < ApplicationController

  
  before_filter :require_user
  
  def index
    @tasks = @current_user.active_tasks
    @tasks_group_by_project = @current_user.tasks_group_by_project
  end

  def new
    @task = Task.new
    @project = Project.find(params[:id])
    @org = @project.organization
    @groups = @org.groups
    
    if @org.creator_id != @current_user.id
      flash[:error] = 'Access Denied'
      redirect_to :controller => "projects", :action => "index"
    end
    
  end

  def create
    @task = Task.create(params[:task])
    @task.project_id = params[:project][:id].to_i
    @task.point = params[:point].to_i
    @task.due = Date.civil(params[:due_date][:year].to_i, params[:due_date][:month].to_i, params[:due_date][:day].to_i)
  
    if @task.save
      if !params[:group].empty? and params[:group] != '-1'
        @group = Group.find(params[:group])   
        @group.tasks << @task
      end
      redirect_to :controller => "projects", :action => "show", :id => params[:project][:id].to_i
    else
      flas[:error] = 'Failed creating a new task'
      redirect_to :action => "new"
    end
  end

  def show
    @task = Task.find(params[:id])
    @project = @task.project
    @org = @project.organization
    
    if @org.creator_id != @current_user.id
      flash[:error] = 'Access Denied'
      redirect_to :controller => "projects", :action => "index"
    end
      
    
  end
  
  def save
    @task = Task.find(params[:task][:id].to_i)
    @task.description = params[:task][:description]
    @task.point = params[:point].to_i
    @task.due = Date.civil(params[:due_date][:year].to_i, params[:due_date][:month].to_i, params[:due_date][:day].to_i)
    @task.status = params[:status].to_i
    if @task.save
      flash[:notice] = "Changes have been saved"
      redirect_to :controller => "projects", :action => "show", :id => @task.project.id
    else
      flas[:error] = 'Failed saving changes'
      redirect_to :action => "show", :id => params[:task][:id].to_i
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    if @task.project.organization.creator_id = @current_user.id
      @task.destroy
    else
      flash[:error] = "Access Denied"
    end
       
    redirect_to :back
  end
  #  
  #  def complete
  #    @id = params[:id]
  #    @task = Task.find(@id)
  #    @org = @task.project.organization
  #    if @org.creator_id == @current_user.id
  #      @task.status = 1
  #      if @task.save
  #        flash[:notice] = "Task completed"
  #      else
  #        flash[:error] = "Failed marking task complete"
  #      end
  #      redirect_to :back
  #    else
  #      render 'projects/access_denied'
  #    end
  #  end
  #  
  #  def incomplete
  #    @id = params[:id]
  #    @task = Task.find(@id)
  #    @org = @task.project.organization
  #    if @org.creator_id == @current_user.id
  #      @task.status = 0
  #      if @task.save
  #        flash[:notice] = "Task is now marked incomplete"
  #      else
  #        flash[:error] = "Failed marking task icomplete"
  #      end
  #      redirect_to :back
  #    else
  #      render 'projects/access_denied'
  #    end
  #  end

end
