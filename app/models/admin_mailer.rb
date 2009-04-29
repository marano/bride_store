class AdminMailer < ActionMailer::Base
  
  def sale(admin_email, sale, url)
    setup_email(admin_email)
    @subject = "Nova Venda"
    body :sale => sale, :url => url
  end
  
  def delivery(admin_email, delivery, url)
    setup_email(admin_email)
    @subject = "Nova Entrega"
    body :delivery => delivery, :url => url
  end

  protected
  def setup_email(to)
    @recipients  = to
    @from        = "Arte de Receber Casa <#{MAILER_ADRESS}>"
    @content_type = "text/html"
    @sent_on = Time.now
  end

end
