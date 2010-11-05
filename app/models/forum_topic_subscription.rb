class ForumTopicSubscription < ActiveRecord::Base
	belongs_to :user
	belongs_to :forum_topic
end
