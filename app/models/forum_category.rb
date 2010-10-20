class ForumCategory < ActiveRecord::Base
	has_many :forum_topics
	has_many :forum_category_subscriptions 
	has_many :subscribers, :class_name => "Member", :through => :forum_category_subscriptions
	
	def topics_by_last_post
		self.forum_topics.delete_if {|t| t.forum_posts.empty?}.sort {|t1, t2| t2.last_post_date <=> t1.last_post_date}
	end
end
