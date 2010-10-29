class LandingController < ApplicationController
  before_filter :current_user

  def index
    #current_navigation :welcome
=begin
    if @current_user
      @no_modal = true
    elsif params[:new_comfirmed_user]
      @new_confirmed_user = true
    elsif cookies[:already_skipped]
      @no_modal = true
    else
=end
    if params[:check_email]
      @check_email = true
    else
      @unknown_user = true
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
