class MemberObserver < ActiveRecord::Observer
  def after_create(member)
    CoopMailer.deliver_signup_notification(member)
  end

  def after_save(member)
    CoopMailer.deliver_activation(member) if member.recently_activated?
  end
end
