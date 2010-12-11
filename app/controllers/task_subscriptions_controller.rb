class TaskSubscriptionsController < ApplicationController
  def create
    task = Task.find params[:task_id]
    if task
      @task_sub = TaskSubscription.create(:task_id => params[:task_id], :user_id => @current_user.id)
      unless @task_sub.errors.any?
        redirect_to task_path task
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

  def destroy
    #TODO
    task_sub = TaskSubscription.find(params[:task_id])
    task = task_sub.task
    if @current_user.is_subscribed_to_task(task)
      task_sub.destroy
      redirect_to task_path(task)
    else
      redirect_to root_url
    end
  end

end
