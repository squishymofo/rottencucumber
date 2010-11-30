require 'spec_helper'

describe Group do
  
  before(:each ) do
    @organization = Factory.create(:organization, :id => 5, :name => "Monkey Patch")
    @group = Factory.create(:group, :id => 1, :organization_id => 5, :name => "Group number 1")
  end
  
  describe "Creating Group" do
    
    it "should return the right organization" do
      @group.organization.id.should == @organization.id
      @group.organization.name.should == @organization.name
    end
    
    it "should say there is only 1 group count" do
      Group.count.should == 1
      @organization.groups.count == 1
    end
    
    it "should say that organization has only 1 group associated to it" do
      @organization.groups.first.id == @group.id
      @organization.groups.first.name == @group.name
    end
    
  end
  
  describe "Creating more groups and assignint it to the same organization" do
    before(:each) do
      @group2 = Factory.create(:group, :id =>2, :organization_id => 5, :name => "Group Number 2")
      @group3 = Factory.create(:group, :id =>3, :organization_id => 5, :name => "Group Number 3")
    end
    
    it "should return organization has 3 groups" do
      @organization.groups.count.should == 3
    end
    
    it "should return the right organization id'" do
      @group2.organization.id.should == @organization.id
      @group3.organization.id.should == @organization.id 
    end
    
    
  end
  
end
