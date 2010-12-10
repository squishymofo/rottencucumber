require 'spec_helper'

# TODO

describe Comment do
  before(:each) do 
    u = create_registered_and_active_user("someone@example.com", "password", "Jimmy")
    @org = Organization.create(:name => "my org", :description => "desc of my org") # create an org
    u.organizations << @org # this is my org
    u.save
    g = Group.create(:name => "test groups", :organization_id => @org.id)
    UserGroup.create(:user_id => u.id, :group_id => g.id) # add the me to the group
    p = Project.create(:name => "do work", :organization_id => @org.id, :description => "description")
    @t = Task.create(:name => "Thing 1 assigned to me", :description => "Description of task 1", :group_id => g.id, :project_id => p.id, :status => 1)
    @valid_attributes = { :body => "This is the body!",
                          :user_id => u.id,
                          :task_id => @t.id}
  end

  after(:each) do 
    User.all.each {|u| u.destroy}
    UserGroup.all.each {|x| x.destroy}
    Group.all.each {|x| x.destroy}
    Project.all.each {|x| x.destroy}
  end

  it "should not allow a new instance without a body" do
    @valid_attributes[:body] = nil
    attrs_without_body = @valid_attributes
    comment = Comment.new(attrs_without_body)
    comment.should_not be_valid
  end

  it "should not allow a new instance without an associated user"do
    @valid_attributes[:user_id] = nil
    attrs_without_user = @valid_attributes
    comment = Comment.new(attrs_without_user)
    comment.should_not be_valid
  end

  it "should not allow a new instance without an associated task"do
    @valid_attributes[:task_id] = nil
    attrs_without_task = @valid_attributes
    comment = Comment.new(attrs_without_task)
    comment.should_not be_valid
  end

  it "should not allow a new instance if the user isn't involved task's project"do
    other_u = create_registered_and_active_user("someone_else@example.com", "password", "Jimmy")
    @valid_attributes[:user_id] = other_u.user_id
    invalid_attributes = @valid_attributes
    comment = Comment.new(invalid_attributes)
    comment.should_not be_valid
  end

end

def create_registered_and_active_user(email, password, first_name)
    u = User.new(:email => email, :password => "password", :password_confirmation => "password", :first_name => first_name)
    u.first_name = first_name
    u.active = true
    u.save(:validate => false)
    u.active = true
    u.save
    u
end

