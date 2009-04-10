class SpamMailer < ActionMailer::Base
  
  def spam(spam, store_url)
    recipients spam.to.to_s
    from "#{spam.user.name} <#{spam.user.email}>"
    subject "#{spam.title}"
    sent_on Time.now
    body :spam => spam, :url => store_url
    content_type "text/html"
  end
end
