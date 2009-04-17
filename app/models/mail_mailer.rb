class MailMailer < ActionMailer::Base
  
  def message(mail)
    @recipients = fetch_to
    @from = "Arte de Receber Casa <#{MAILER_ADRESS}>"
    @subject = mail.title
    @sent_on = Time.now
    @content_type = "text/html"
    body :mail => mail, :has_image => mail.image.file?, :image => "http://#{SITE_URL + mail.image.url}" 
  end
  
  private
  
  def fetch_to
    users = User.newsletters
    adresses = []
    users.each do |user|
      adresses << "#{user.name} <#{user.email}>"
    end
    adresses
  end
  
end
