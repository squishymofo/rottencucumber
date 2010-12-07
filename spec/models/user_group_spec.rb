require 'spec_helper'

describe UserGroup do
  before(:each) do
    @user1 = Factory.create(:user,  :email => "Monkey1@monkey.com" )
    @user2 = Factory.create(:user,  :email => "Monkey2@monkey.com" )
    @group = Factory.create(:group,  :name => "Monkeys")
  end
  
  describe "adding users to groups" do
    before(:each) do
      @group.users << @user1
      @group.users << @user2
      @group.save!
    end
    
    it "should include the two users when asked" do
      @group.users.should include @user1
      @group.users.should include @user2
    end
    
    it "should include the group when asked for the groups that the user is in" do
      @user1.groups.should include @group
      @user2.groups.should include @group
    end
  end
  
  
end
