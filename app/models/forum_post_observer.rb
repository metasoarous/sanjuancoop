class ForumPostObserver < ActiveRecord::Observer
  
  # Sends the update to the member when new post is created if that post is in a topic that the user subscribes to.
  def after_create(fp)
    fp.forum_topic.subscribers.each do |member|
      CoopMailer.deliver_forum_topic_update(member, fp)
    end
  end
  
  # Need to write a test for this, but for now, okay
  def before_destroy(fp)
    fp.forum_topic.destroy if fp.forum_topic and fp.forum_topic.forum_posts = [fp]
  end
end
