MAILER_ADRESS = 'thiagorsouz@gmail.com'

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :tls => true,
  :adress => 'smtp.gmail.com',
  :port => 587,
  :authentication => :login,
  :user_name => 'thiagorsouz@gmail.com',
  :password => 'trs9255'
}
