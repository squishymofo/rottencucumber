class UserMailer < ActionMailer::Base
  default :from => "NitrousDomus@gmail.com"
  def registration_confirmation(user)  
    mail(:to => user.email, :subject => "Registered")  
  end  

  def activation_instructions(user)
    @user = user
    mail(:to => user.email, :subject => "Activation Instructions")
  end

  def activation_confirmation(user)
    @user = user
    mail(:to => user.email, :subject => "Activation Complete")
  end

end
