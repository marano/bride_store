class FaleConosco < ActionMailer::Base
  
  def message(admin_email, name, email, phone, message)
    @recipients = admin_email
    @from = "#{name} <#{email}>"
    @subject = "Fale Conosco ADR - #{name}"
    @sent_on = Time.now
    @content_type = "text/html"
    body :name => name, :email => email, :phone => phone, :message => message
  end
  
end
