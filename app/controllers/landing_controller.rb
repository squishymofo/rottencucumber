class LandingController < ApplicationController
  before_filter :current_user

  def index
    current_navigation :home
    if params[:check_email]
      @check_email = true
    else
      @unknown_user = true
    end
    if @current_user
      @tasks = @current_user.active_tasks_from_projects_involved_in.includes(:comments)
      @most_recent_comment_ids = @tasks.map {|t| "#{t.latest_comment.id}" if t.comments.any? }.delete_if {|i| !i}.join("-")
    end
  end

  def skip_it
    cookies.permanent[:already_skipped] = true
    render :nothing => true
  end

  def about_us
    current_navigation :about_us
  end

  def blog
    current_navigation :blog
  end

end
