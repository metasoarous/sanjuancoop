class MemberObserver < ActiveRecord::Observer
  def after_create(member)
    CoopMailer.signup_notification(member).deliver
    ForumCategory.all.each do |cat|
      sub = ForumCategorySubscription.new(:forum_category_id => cat.id, :member_id => member.id, :frequency => "weekly")
      sub.save
    end
  end

  def after_save(member)
    CoopMailer.activation(member).deliver if member.recently_activated?
  end
end
