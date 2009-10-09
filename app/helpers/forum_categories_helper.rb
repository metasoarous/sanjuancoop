module ForumCategoriesHelper
  def fetch_topics(category,n)
    topics = category.forum_topics.sort do |top1, top2|
      top1.forum_posts.last.created_at <=> top2.forum_posts.last.created_at
    end
    return topics.reverse
  end
end
