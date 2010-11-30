require 'spec_helper'

describe Organization do
  
  before :each do
    @organization_owner = Factory.create(:user, :email => "dennis@dennis.com")
    @organization = Factory.create(:organization, :name => "dennis.com", :description => "Dennis Company", :creator_id => @organization_owner.id)
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
