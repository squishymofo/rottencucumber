class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation
  
  has_many :user_organizations
  has_many :organizations, :through => :user_organizations
  
  has_many :user_groups
  has_many :groups, :through => :user_groups
  
  acts_as_authentic do |c|
    c.login_field = 'email'
    c.validates_length_of_password_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validates_length_of_password_confirmation_field_options = {:on => :update, :minimum => 4, :if => :has_no_credentials?}
    c.validate_email_field    = false
    #c.validate_login_field    = false
    #c.validate_password_field = false
  end
  
  has_many :invited_users, :class_name => "User", :foreign_key => "invited_by_id"
  belongs_to :invited_by, :class_name => "User", :foreign_key => "invited_by_id"
  
  has_many :tickets
  has_many :time_slots, :through => :tickets

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

end
