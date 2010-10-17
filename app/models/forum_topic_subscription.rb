class ForumTopicSubscription < ActiveRecord::Base
  belongs_to :member
  belongs_to :forum_topic
end
