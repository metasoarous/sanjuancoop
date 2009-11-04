class ForumPost < ActiveRecord::Base
  belongs_to :forum_topic
  belongs_to :member
  
  validates_presence_of :body
  
  def forum_category
    forum_topic.forum_category
  end
  
  # Need to write a test for this, but for now, okay
  def after_destroy
    forum_topic.destroy if forum_topic.forum_posts.empty?
  end
end
