require 'spec_helper'

describe Project do
  before(:each) do
    @project_count = Project.count
    @organization = Factory.create(:organization, :name => "Communist Party", :name => "Fooood")
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
    
    
    
  end
end
