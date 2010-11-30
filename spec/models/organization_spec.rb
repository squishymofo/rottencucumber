require 'spec_helper'

describe Organization do
  
  before :each do
    Factory.create(:user, :email => "dennis@dennis.com", :id => 2009)
    Factory.create(:organization, :id => 20, :name => "dennis.com", :description => "Dennis Company", :creator_id => 2009)
    @organization_owner = User.find(2009)
    @organization = Organization.find(20)
  end
  
  describe "user as the creator of an organization" do
    
    it "should set the creator id as the one who created the organization" do  
      @organization.creator_id.should == @organization_owner.id
    end
    
    it "should have no member when it is first created" do
      @organization.users.count.should == 0
    end
    
  end
  
end
