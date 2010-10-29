ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",  
  :port                 => 587,  
  :domain               => "nitrousdomus.com",  
  :user_name            => "nitrousdomus",  
  :password             => "ohio1696",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}

ActionMailer::Base.default_url_options[:host] = "localhost:3000"
