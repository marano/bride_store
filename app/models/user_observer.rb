class UserObserver < ActiveRecord::Observer

  def after_save(user)
    UserMailer.deliver_signup_notification(user) if user.recently_registered?
    UserMailer.deliver_activation(user) if user.recently_activated? unless user.admin?
  end
end

