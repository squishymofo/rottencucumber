class GroupsController < ApplicationController
  def index
    @groups = Group.find(:all)
  end

  def show
    
  end

  def new
    @group = Group.new
    
  end

  def create
    
  end

end
