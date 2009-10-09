class MemberObserver < ActiveRecord::Observer
  def after_create(member)
    MemberMailer.deliver_signup_notification(member)
  end

  def after_save(member)
    MemberMailer.deliver_activation(member) if member.recently_activated?
  end
end
