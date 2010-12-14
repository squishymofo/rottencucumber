class TasksController < ApplicationController

  
  before_filter :require_user, :except => [:get_new_comments]
  
  def index
    current_navigation :tasks
    # NOTE: write features first 
    @my_organizations_tasks = @current_user.active_tasks
    @tasks = @current_user.active_tasks
    @tasks_group_by_project = @current_user.tasks_group_by_project
  end

  def get_new_comments
    @new_comments = [ ]
    # what if no comments?
    # -> params[tnum] = "undefined"
    
    @new_comments = [ ]
    params.each_pair {|k, v| @new_comments += Task.find(k).get_comments_after(v) if k =~ /^[0-9]+$/}

  end

  def new
    current_navigation :tasks
    @task = Task.new
    @project = Project.find(params[:id])
    @org = @project.organization
    @groups = @org.groups
    
    if @org.creator_id != @current_user.id
      flash[:error] = 'Access Denied'
      redirect_to :controller => "projects", :action => "index"
    end
    
  end

  def new_task_ajax
    @project = Project.find(params[:project_id])
    unless @project.organization.creator == @current_user
      render :nothing => true
    else
      @team_members = @project.organization.users.order('reputation desc')
      @task = Task.new
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
      flash[:error] = 'Failed creating a new task'
      redirect_to :action => "new"
    end
  end

  def create_task_for_project
    project = Project.find params[:project_id]
    selected_users = [ ]
    params.each_pair do |key, value| 
      debugger
      if key =~ /^user-/
        selected_users.push(User.find(value))
      end
    end
    if selected_users.empty?
      redirect_to root_url
    end
    g = Group.create!(:name => "impromptu group")
    selected_users.each do |u| 
      u.groups << g
      u.save(:validate => false)
    end
    t = Task.new(:group_id => g.id, :name => params[:name], :status => 1, :description => params[:description], :project_id => project.id, :point => params[:points])
    t.save
    redirect_to root_url
  end

  def show
    # TODO test this
    @task = Task.find(params[:id])
    can_view = @task.can_user_access?(@current_user)
    unless can_view
      flash[:error] = 'Access Denied'
      redirect_to :controller => root_url
    end

    current_navigation :tasks
    @task = Task.find(params[:id])
    @task_subscription = TaskSubscription.get_subscription(@current_user, @task)
    unless @task_subscription
      @task_subscription = TaskSubscription.new(:task_id => @task.id, :user_id => @current_user.id)
    end
    @project = @task.project
    @org = @project.organization
  end

  def edit
    @task = Task.find(params[:id])
    @project = @task.project
    @org = @project.organization
    
    if @org.creator_id != @current_user.id
      flash[:error] = 'Access Denied'
      redirect_to :controller => "projects", :action => "index"
    end
  end

  def update
    #TODO
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
      flash[:error] = 'Failed saving changes'
      redirect_to :action => "show", :id => params[:task][:id].to_i
    end
  end

  def comment
    @task = Task.find params[:id]
    if @current_user.tasks_from_projects_involved_in.include?(@task)
      @comment = Comment.new(:body => params[:comment_body], :user_id => @current_user.id, :task_id => @task.id)
      if @comment.save
        redirect_to task_path(@task)
      else
        #TODO errors!
        @error_comment = @comment
        @comments = @task.comments
        render :show
      end
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

  def finish
    @task = Task.find(params[:task_id])
    if @current_user.tasks.include?(@task)
      @task.finish!(@current_user)
      redirect_to task_path(@task)
    else
      flash[:error] = "You can't do that"
      redirect_to root_url
    end
  end
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

