class InvitationsController < ApplicationController
  before_filter :current_user
  before_filter :require_user
  
  def index
    
  end
  
  def new
    @organization = Organization.find(params[:org_id])
    
    if @organization.creator_id != @current_user.id
      redirect_to :action => "index"
    else
      @invitation = Invitation.new
    end
  end
  
  def create
    @user = User.find_by_email(params[:email])
    
    if @user.nil?
      flash[:warning] = "User does not appear to have an account with Rotten Cucumber"
      redirect_to :back
    elsif @user.id == @current_user.id       
      flash[:warning] = "You cannot invite yourself"
      redirect_to :back
    else
      @invitation = Invitation.create(:organization_id => pararms[:org_id], :user_id => @user.id)
      redirect_to :controller => "organizations", :action => "show", :id => params[:org_id]
    end
  end
end
