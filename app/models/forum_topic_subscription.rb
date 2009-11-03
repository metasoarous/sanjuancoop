class ForumTopicSubscription < ActiveRecord::Base
  belongs_to :members
  belongs_to :forum_topics
end
