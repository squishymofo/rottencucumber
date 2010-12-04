class TasksController < ApplicationController

  
  before_filter :require_user
  
  def index

    @my_organizations_tasks = @current_user.active_tasks
    
  end

  def new
    @task = Task.new
    @project = Project.find(params[:proj_id])
    @org = @project.organization
    
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
      redirect_to :controller => "projects", :action => "show", :id => params[:project][:id].to_i
    else
      flas[:error] = 'Failed creating a new task'
      redirect_to :action => "new"
    end
  end

  def show
    @task = Task.find(params[:id])
  end
  
  # def delete
  #    @task = Task.find(params[:id])
  #    if @task.organization.creator_id = @current_user.id
  #      @task.destroy
  #    else
  #      flash[:error] = "You are not authorized to perform such action"
  #    end
  #    
  #    redirect_to :back
  #  end
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
