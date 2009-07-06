class UserMailer < ActionMailer::Base
  def signup_notification(user)
    setup_email(user)
    @subject    += 'Ative sua conta'
    @body[:url]  = "http://#{SITE_URL}/activate/#{user.activation_code}"
  end

  def activation(user)
    setup_email(user)
    @subject    += 'Sua conta foi ativada!'
    @body[:url]  = "http://#{SITE_URL}/"
  end
  
  def password(user)
    setup_email(user)
    @subject += 'Nova senha!'
    @body[:password] = user.password
  end
  
  def sale_notification(user, sale)
    setup_email(user)
    @subject += 'Novo presente!'
    @body[:sale] = sale
  end
  
  def message_notification(user, message)
    setup_email(user)
    @subject += 'Novo presente!'
    @body[:message] = message
  end

  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "Arte de Receber Casa <#{MAILER_ADRESS}>"
    @subject     = "[ADR] "
    @sent_on     = Time.now
    @content_type = "text/html"
    @body[:user] = user
  end
end
