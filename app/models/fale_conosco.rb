class FaleConosco < ActionMailer::Base
  
  def message(to, name, email, phone, message)
    @recipients = to
    @from = "#{name} <#{email}>"
    @subject = "Fale Conosco ADR - #{name}"
    @sent_on = Time.now
    @content_type = "text/html"
    body :name => name, :email => email, :phone => phone, :message => message    
  end
  
end
