class Spam < ActiveRecord::Base
  
  belongs_to :list
  has_attached_file :photo, :styles => { :original => '320x240>' }
  
  def enviar
    SpamMailer.deliver_spam(self)
    sent_spam = Spam.new
    sent_spam.list = list
    sent_spam.title = title
    sent_spam.body = body
    sent_spam.photo = photo
    sent_spam.to = to
    sent_spam.sent = true
    sent_spam.save
  end
  
  def user
    list.user
  end
  
  def sent?
    sent
  end
  
end
