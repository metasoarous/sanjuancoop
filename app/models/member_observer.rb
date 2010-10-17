class MemberObserver < ActiveRecord::Observer
  def after_create(member)
    CoopMailer.deliver_signup_notification(member)
    ForumCategory.all.each do |cat|
      sub = ForumCategorySubscription.new(:forum_category_id => cat.id, :member_id => member.id, :frequency => "weekly")
      sub.save
    end
  end

  def after_save(member)
    CoopMailer.deliver_activation(member) if member.recently_activated?
  end
end
