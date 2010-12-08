class InvitationsController < ApplicationController
  before_filter :current_user
  before_filter :require_user
  
  def index
    @received = @current_user.invitations
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
    @organization = Organization.find(params[:org_id])
    
    if @user.nil?
      flash[:warning] = "User does not appear to have an account with Rotten Cucumber"
      redirect_to :back
    elsif @user.id == @current_user.id       
      flash[:warning] = "You cannot invite yourself"
      redirect_to :back
    elsif @organization.users.include? @user
      flash[:warning] = "That user is already in this organization"
      redirect_to :controller => "organizations", :action => "show", :id => params[:org_id]
    else
      @invitation = Invitation.create(:organization_id => params[:org_id], :user_id => @user.id)
      redirect_to :controller => "organizations", :action => "show", :id => params[:org_id]
    end
    
  end
  
  def proceed
    if params[:submit] == "Accept"
      
      invitation = Invitation.find(params[:inv_id])
      organization = Organization.find(invitation.organization_id)
      if !organization.users.include? @current_user
        organization.users << User.find(@current_user.id)
      end
      invitation.destroy
      
    elsif params[:submit] == "Decline"
      
      invitation = Invitation.find(params[:inv_id])
      invitation.destroy
      
    end
    
    redirect_to :back
  end
end
 