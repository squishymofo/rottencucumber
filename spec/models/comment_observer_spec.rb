require 'spec_helper'

# TODO

describe Comment do
  before(:each) do 
  end

  after(:each) do 
  end

  it "should send comments to users who are subscribed to this task"do
    debugger
    #need  task, org, usergroup, project .. look at comment spec for ex
    pending
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

