class TasksController < ApplicationController
  
  before_filter :current_user
  
  def index
    
  end

  def new
    
  end

  def create
    
  end

  def show
    
  end
  
  def complete
    @id = params[:id]
    @task = Task.find(@id)
    @org = @task.project.organization
    if @org.creator_id == @current_user.id
      @task.status = 1
      if @task.save
        flash[:notice] = "Task completed"
      else
        flash[:error] = "Failed marking task complete"
      end
      redirect_to :back
    else
      render 'projects/access_denied'
    end
  end
  
  def incomplete
    @id = params[:id]
    @task = Task.find(@id)
    @org = @task.project.organization
    if @org.creator_id == @current_user.id
      @task.status = 0
      if @task.save
        flash[:notice] = "Task is now marked incomplete"
      else
        flash[:error] = "Failed marking task icomplete"
      end
      redirect_to :back
    else
      render 'projects/access_denied'
    end
  end

end
