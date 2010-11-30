require 'spec_helper'

describe Task do
  before(:each) do
    @task_count = Task.count
    @due_date = 2.days.from_now
    @project = Factory.create(:project, :name => "Build a Lemon Tree", :description => "Lemon Tree Building")
    @organization = Factory.create(:organization, :name => "dennis.com", :description => "Dennis Company", :creator_id => 9999999)
    @group = Factory.create(:group, :organization_id => @organization.id , :name => "Group Awesome")
    @task = Factory.create(:task, :name => "Task Me", :description => "A New Task", :due => @due_date, :group_id => @group.id, :project_id => @project.id)
  end
  
  describe "Creating a task" do
    it "should return the correct count when asked how many tasks are in the table" do
      Task.count.should == (@task_count + 1)
    end
    
    it "should return the right name" do
      @task.name.should == "Task Me"
    end

    it "should return the right description" do
      @task.description.should == "A New Task"
    end

    it "should return the right due date" do
      @task.due.should == @due_date
    end
  end
  
  describe "Association with group and organization" do
    puts @organization
    it "should return the right organization id" do
      @task.project.id.should == @project.id      
    end
    
    it "should return the right group id" do
      @task.group.id.should == @group.id
    end
  end

end
