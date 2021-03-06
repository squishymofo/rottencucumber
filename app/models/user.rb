class User < ActiveRecord::Base
  require 'lib/valid_phone_number_validator'
  attr_accessible :username, :email, :password, :password_confirmation
  
  has_many :user_organizations
  has_many :organizations, :through => :user_organizations do
    def projects
      @projects ||=Project.where(:organization_id => map(&:id)).order('created_at ASC')
    end
  end
  has_many :user_groups

  has_many :task_subscriptions

  def is_subscribed_to_task(task)
    task_subscriptions.where(:user_id => self.id, :task_id => task.id).any?
  end
  
  has_many :invitations
  # Task.where(:project_id => u.active_tasks.map(&:project_id))

  #TODO: optimize !!
  has_many :groups, :through => :user_groups do
    def active_tasks
      @tasks ||=Task.where(:group_id => map(&:id)).order('created_at ASC').where(:status => 1)
    end
    def tasks
      @tasks ||=Task.where(:group_id => map(&:id)).order('created_at ASC')
    end
    def users_in_groups_with_me
      @users_in_group_with_me = []
      @users_in_group_with_me.each {|group|  @users_in_group += group.users }
      @users_in_group_with_me
    end
  end
  
  acts_as_authentic do |c|
    c.login_field = 'email'
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validate_email_field    = false
    #c.validate_login_field    = false
    #c.validate_password_field = false
  end
  
  validates :email, :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  validates :phone_number, :valid_phone_number => true
  
    # !!!! willl need to change back once fb connect etc
  def has_no_credentials?
    # self.crypted_password.blank? && AccessToken.find_by_user_id(id).nil?
    self.crypted_password.blank?
  end
  
  has_one :access_token
  
  def active?
    active
  end

  def signup!(params)
    # also need to save first_name, last_name, etc. and optionally bd_year, zip
    self.email = params[:email]
    save_without_session_maintenance
  end

  def signup_str!(email, invited_by_id)
    self.email = email
    self.invited_by_id = invited_by_id
    save_without_session_maintenance
  end

  def send_invitation!(email)
    UserMailer.invite_user(email, self).deliver
  end

  def activate!(params)
    self.active = true
    self.password = params[:password] 
    self.password_confirmation = params[:password_confirmation]
    save
  end

  def deliver_activation_instructions!
    reset_perishable_token!
    UserMailer.activation_instructions(self).deliver
  end

  def deliver_activation_confirmation!
    reset_perishable_token!
    UserMailer.activation_confirmation(self).deliver
  end

  def signup_with_facebook
    profile = JSON.parse(@user.access_token.get("/me"))
    email = profile["email"]
    first_name = profile["first_name"]
    last_name = profile["last_name"]
    active = true
    save
  end

  ## should these be scopes?

  def active_tasks
    groups.active_tasks
  end

  def tasks
    groups.tasks
  end
  
  def tasks_group_by_project
    h = {} # an hash mapping a project to a list of tasks
    self.organizations.each do |org|
      org.projects.each do |proj|
        h[proj] = Task.find_all_by_project_id(proj.id)
      end
    end
    return h
  end

  def active_tasks_in_projects
  end
  
  def get_users_in_groups_with_me
    self.groups.users_in_groups_with_me
  end

  def most_active_organization
    organizations.order('organizations.updated_at DESC').first
  end

  def active_tasks_from_projects_involved_in
    # NOTE: probably horrible
    tasks_from_projects_involved_in.where(:status => 1)
  end

  def tasks_from_projects_involved_in
    #NOTE: tasks don't get deleted. If you 
    # NOTE: probably horrible
    Task.where(:project_id => tasks.map(&:project_id))
  end

  def can_finish_task?(task)
    tasks.include?(task)
  end
  
  def projects
    Project.where(:id => tasks.map(&:project_id))
  end

  def send_comment_over_sms(u, body)
    account = Twilio::RestAccount.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    h = {:From => PHONE_NUMBER, :To => self.phone_number, :Body => body}
    resp = account.request("/#{API_VERSION}/Accounts/#{ACCOUNT_SID}/SMS/Messages", 'POST', h)
    resp
  end

end
