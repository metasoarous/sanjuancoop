module ForumCategoriesHelper
  # Orders the topics of the category by the most recently added to and then either returns the first n of those posts or :all of them based on whether n is a number or something else (send in :all)
  def fetch_topics(category,n)
    topics = category.forum_topics.sort do |top1, top2|
      top1.forum_posts.last.created_at <=> top2.forum_posts.last.created_at
    end
    topics = topics.reverse
    if n.is_a? Numeric
      topics = topics[0...n]
    end
  end
  
  # This cleans up the render :partial => category call which was starting to get messy with logic to dry things up. This breathes much better...
  def render_forum_topic_index(category, topics, all_disc_link, options = {})
    options = {:partial => "category"}.merge options
    render :partial => "category", :locals => {:category => category, :topics => topics, :all_discussions_link => all_disc_link}
  end
end
