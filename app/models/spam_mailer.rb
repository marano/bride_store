class SpamMailer < ActionMailer::Base
  
  def spam(spam)
    recipients spam.to.to_s
    from "#{spam.user.name} <#{spam.user.email}>"
    subject "#{spam.title}"
    sent_on Time.now
    body :spam => spam
    content_type "text/html"
  end
end
