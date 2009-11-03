class ForumCategory < ActiveRecord::Base
  has_many :forum_topics
  has_many :forum_category_subscriptions 
  has_many :subscribers, :class_name => "Member", :through => :forum_category_subscriptions
end
