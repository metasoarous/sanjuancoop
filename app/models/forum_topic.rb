class ForumTopic < ActiveRecord::Base
  belongs_to :forum_category
  has_many :forum_posts
  has_many :forum_topic_subscriptions
  has_many :subscribers, :class_name => "Member", :through => :forum_topic_subscriptions, :source => :member
  
  accepts_nested_attributes_for :forum_posts, :allow_destroy => true
  
  validates_presence_of :subject
  validates_numericality_of :forum_category_id, 
          :message => "You must select a forum category before posting"
  validates_associated :forum_category, :forum_posts
  
  def last_post_date
    return self.forum_posts.map {|p| p.created_at }.max
  end
end
