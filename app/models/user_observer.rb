class UserObserver < ActiveRecord::Observer
	def after_create(user)
		CoopMailer.signup_notification(user).deliver
		ForumCategory.all.each do |cat|
			sub = ForumCategorySubscription.new(:forum_category_id => cat.id, :user_id => user.id, :frequency => "weekly")
			sub.save
		end
	end

	def after_save(user)
		CoopMailer.activation(user).deliver if user.recently_activated?
	end
end
