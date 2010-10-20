class CoopMailer < ActionMailer::Base
	
	helper :forum, :application

	default :from => "SJI-Coop<no-reply@sanjuancoop.org>"
	
	# Delivers signup notifications
	def signup_notification(member)
		@url = "http://#{WEBSITEURL}/activate/#{member.activation_code}"
		mail :to => member.email, :subject => "Please activate your new account"
	end
	
	# delivers account activations
	def activation(member)
		@url	= "http://#{WEBSITEURL}/"
		mail :to => member.email, :subject => "Website Registration: Your account has been activated!"
	end
	
	# delivers newsletters
	def newsletter(deliver_to, newsletter)
		addy = (deliver_to.class == Membership or deliver_to.class == Member) ? deliver_to.email : deliver_to
		@body = newsletter.body
		mail :to => addy, :subject => newsletter.subject
	end
	
	# Set this one up to send notifications/updates of a single topics new posts
	def forum_topic_update(member, forum_post)
		@post = forum_post
		mail :to => member.email, :subject => "Coop Forum Update: #{forum_post.forum_topic.subject}"
	end
	
	# Set this up to send out digest style updates
	def forum_category_update(member)
		member.forum_category_subscriptions.each do |sub|
			#crap is not a method - need to work on this
			sub.forum_category.crap
		end
	end
end
