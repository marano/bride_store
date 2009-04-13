class Spam < ActiveRecord::Base
  
  belongs_to :list
  has_attached_file :photo, :styles => { :original => '512x384>' }
  
  default_scope :order => 'created_at DESC'
  
  def enviar(store_url)
    SpamMailer.deliver_spam(self, store_url)
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
