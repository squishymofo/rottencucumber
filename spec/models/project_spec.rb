require 'spec_helper'

describe Project do
  before(:each) do
    @project_count = Project.count
    @organization = Factory.create(:organization, :name => "Communist Party", :description => "Fooood")
    @project = Factory.create(:project, :name => "Dennis Project", :description => "Gotta finish this shit", :organization_id => @organization.id)
  end
  
  describe "Project Creation" do
    it "should give the correct project count" do
      Project.count.should == (@project_count + 1)
    end
    
    it "should return the right project name" do
      @project.name.should == "Dennis Project"
    end
    
    it "should return the right description" do
      @project.description.should == "Gotta finish this shit"
    end
  end
  
  describe "Association with Organization" do
    it "should return the correct organization id" do
      @project.organization.id.should == @organization.id      
    end
    
    it "should return the correct organization name" do
      @project.organization.name.should == "Communist Party"
    end
  end
end
