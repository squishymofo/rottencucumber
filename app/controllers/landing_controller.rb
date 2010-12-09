class LandingController < ApplicationController
  before_filter :current_user

  def index
    if params[:check_email]
      @check_email = true
    else
      @unknown_user = true
    end
    if @current_user
      @tasks = @current_user.active_tasks_from_projects_involved_in
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
