class ForumPostObserver < ActiveRecord::Observer
	
	# Sends the update to the user when new post is created if that post is in a topic that the user subscribes to.
	def after_create(fp)
		fp.forum_topic.subscribers.each do |user|
			CoopMailer.forum_topic_update(user, fp).deliver
		end
	end
	
	# Need to write a test for this, but for now, okay
	def before_destroy(fp)
		fp.forum_topic.destroy if fp.forum_topic and fp.forum_topic.forum_posts = [fp]
	end
end
