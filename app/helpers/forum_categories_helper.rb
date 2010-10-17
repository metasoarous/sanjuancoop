module ForumCategoriesHelper
  # Orders the topics of the category by the most recently added to and then either returns the first n of those posts or :all of them based on whether n is a number or something else (send in :all)
  def fetch_topics(category,n = 7)
    return category.topics_by_last_post[0...n]
  end
  
  # This cleans up the render :partial => category call which was starting to get messy with logic to dry things up. This breathes much better...
  def render_forum_topic_index(category, topics, all_disc_link, options = {})
    options = {:partial => "category"}.merge options
    render :partial => "category", :locals => {:category => category, :topics => topics, :all_discussions_link => all_disc_link}
  end
end
