require 'spec_helper'

describe UserOrganization do
  before(:each) do
    @user = Factory.create(:user, :email => "Monkey@Monkey.com")
    @user2 = Factory.create(:user, :email => "Monkey2@Monkey.com")
    @organization = Factory.create(:organization, :name => "Monkeys", :description => "Monkeys organization")
  end
  
  describe "Adding users to an organization" do
    
    before(:each) do
      @organization.users << @user
      @organization.users << @user2
      @organization2 = Factory.create(:organization, :name => "Primates", :description => "Primates organization")
      @organization2.users << @user
      @organization2.save
      @organization.save
    end
    
    it "should return all the users wen the organization is asked for all of its users" do
      @organization.users.should include @user
      @organization.users.should include @user2      
    end
    
    it "should return the organizations that the users are in when asked for it" do
      @user.organizations.should include @organization
      @user2.organizations.should include @organization
      @user.organizations.should include @organization2
    end
    
  end
end
