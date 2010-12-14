require 'spec_helper'


describe SmsProcessor do
  #TODO: it should not allow a phone number of a user who doesn't have sms enabled
  before(:each) do 
    @user = make_active_user_with_sms_enabled
    @org = Organization.create(:name => "my org", :description => "desc of my org") # create an org
    @user.organizations << @org # this is my org
    @user.save
    @g = make_group_for_user(@user)
    @t = make_task_for_group(@org, "task 1")
    @p = Project.create(:name => "do work", :organization_id => @org.id, :description => "description")
    @t.project_id = @p.id
    @t.save
    @sms_session = SmsSession.get_sms_session("4405548235")
  end

  after(:each) do 
    SmsSession.all.each {|s| s.destroy}
    User.all.each {|u| u.destroy}
  end

  it "be successful in sending response" do
    pending
    #check the body of the resp
  end

  it "should respond with a numbered list of the user's active tasks when texted 'tasks'" do
    @sms_processor = SmsProcessor.new(@sms_session, "tasks")
    @sms_processor.process_message
    #"1. task 1\nreply with the task number for a description or more for more"
    assert @sms_processor.response_message == ("1. task 1\n" + @sms_processor.list_tasks_instructions(@sms_processor.response_message.size))
  end

  it "should respond with the general help menu when texted 'help' when no task context" do
    @sms_processor = SmsProcessor.new(@sms_session, "help")
    @sms_processor.process_message
    #"1. task 1\nreply with the task number for a description or more for more"
    assert @sms_processor.response_message == @sms_processor.general_help_menu
  end

  it "should respond with task specific help menu when texted 'help' while in a task context" do
    @sms_session.task_id = @t.id
    @sms_session.save
    @sms_session.should be_valid
    @sms_processor = SmsProcessor.new(@sms_session, "help")
    @sms_processor.process_message
    #"1. task 1\nreply with the task number for a description or more for more"
    assert @sms_processor.response_message == @sms_processor.tasks_help_menu
  end

  it "should switch task context when texted a task number" do
    @sms_processor = SmsProcessor.new(@sms_session, @t.id.to_s)
    @sms_processor.process_message
    assert @sms_session.task_id == @t.id
  end

  it "should make a new comment on a task when a user is in that task context and texts in 'say comment_body'" do
    @sms_session.task_id = @t.id
    @sms_session.save
    @sms_processor = SmsProcessor.new(@sms_session, "say what's sms?")
    @sms_processor.process_message
    assert @t.comments.first.user_id == @user.id
    assert @t.comments.first.body == "what's sms?"
    assert @sms_processor.response_message == ""
  end

  it "should finish whatever task is in context when texted finish" do
    @sms_session.task_id = @t.id
    @sms_session.save
    assert @sms_session.task_id == @t.id
    @sms_processor = SmsProcessor.new(@sms_session, "finish")
    @sms_processor.process_message
    Task.all.each {|t| assert t.status == 2}
  end

  it "should not make a comment if the user doesn't have any task context when they try to comment" do
    @sms_processor = SmsProcessor.new(@sms_session, "say what's sms?")
    @sms_processor.process_message
    assert Comment.all.size == 0
    assert @sms_processor.response_message == @sms_processor.general_help_menu
  end

  it "should not allow a user to comment on a task if they're not involved in the task's project" do
    @sms_processor = SmsProcessor.new(@sms_session, "say what's sms?")
    @sms_processor.process_message
    assert Comment.all.size == 0
    assert @sms_processor.response_message == @sms_processor.general_help_menu
  end

  it "should send a new task notification over sms when asked" do
    SmsProcessor.deliver_new_task_notification(sms_session, task) unless Rails.env == "test"
    #assert @sms_processor.response_message == ("New task: #{task_name}. " + @sms_processor.general_help_menu)
  end

end

def make_active_user_with_sms_enabled
  u = User.new(:email => "spitfire67@berkeley.edu", :password => "password", :password_confirmation => "password", :first_name => "James")
  u.first_name = "James"
  u.active = true
  u.save(:validate => false)
  u.active = true
  u.save
  assert u.active
  u.phone_number = "4405548235"
  u.sms_enabled = true
  u.save
  u
end

def make_group_for_user(user)
  g = Group.create!(:name => "test_group")
  user.groups << g
  user.save(:validate => false)
  g
end

def make_task_for_group(group, task_name)
  Task.create(:group_id => group.id, :name => task_name, :status => 1)
end
