class ForumPost < ActiveRecord::Base
	belongs_to :forum_topic
	belongs_to :member
	
	validates_presence_of :body
	
	def forum_category
		forum_topic.forum_category
	end
end
