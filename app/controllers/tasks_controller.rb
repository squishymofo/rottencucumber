class TasksController < ApplicationController
  
  before_filter :current_user
  
  def index
    # @my_organizations = Organization.where("creator_id = ?", @current_user.id)
    # @my_organizations_ids = @my_organizations.map { |k| k.id}
    # 
    # @my_organizations_tasks = Task.where("organization_id IN (?)", @my_organizations_ids).order("organization_id DESC")
    # @joined_organizations = User.find(@current_user.id).organizations

    @my_organizations_tasks = @current_user.active_tasks
    
  end

  def new
    # @task = Task.new
    # @my_orgs = Organization.where("creator_id = ? ", @current_user.id)
    # @orgs_array = []
    # 
    # @my_orgs.each do |org|
    #   @orgs_array << [org.name, org.id]
    # end
    
  end

  def create
    # @task = Task.new
    # @task.point = params[:point].to_i
    # @task.name = params[:task][:name]
    # @task.description = params[:task][:description]
    # @task.organization_id = params[:organization_id]
    # @task.due = Date.civil(params[:due_date][:year].to_i, params[:due_date][:month].to_i, params[:due_date][:day].to_i)
    # @task.save!
  end

  def show
    @task = Task.find(params[:id])
  end
  
  def delete
    @task = Task.find(params[:id])
    if @task.organization.creator_id = @current_user.id
      @task.destroy
    else
      flash[:error] = "You are not authorized to perform such action"
    end
    
    redirect_to :back
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
