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

  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "ADR <#{MAILER_ADRESS}>"
    @subject     = "[ADR] "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
