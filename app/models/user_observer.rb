class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserMailer.deliver_signup_notification(user) unless user.admin?
  end

  def after_save(user)
    unless user.admin?
      UserMailer.deliver_activation(user) if user.recently_activated?
    end
  end
end

