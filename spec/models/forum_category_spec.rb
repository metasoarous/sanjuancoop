require File.dirname(__FILE__) + '/../spec_helper'

describe ForumTopic do
	before(:each) do
		# Hmm... Was getting existing records - wonder why
		[ForumTopic, Member, ForumPost, ForumCategory].each {|m| m.destroy_all}
	end
	
	describe "topics_by_last_post method" do
		before(:each) do
			@forum_category = Factory :forum_category, :id => 1

			@topic1 = Factory :forum_topic, :id => 1, :forum_category_id => 1
			Factory :forum_post, :forum_topic_id => 1, :created_at => Time.now - 4000
			Factory :forum_post, :forum_topic_id => 1, :created_at => Time.now - 5000
			Factory :forum_post, :forum_topic_id => 1, :created_at => Time.now - 6000

			@topic3 = Factory :forum_topic, :id => 2, :forum_category_id => 1
			Factory :forum_post, :forum_topic_id => 2, :created_at => Time.now
			Factory :forum_post, :forum_topic_id => 2, :created_at => Time.now - 500
			Factory :forum_post, :forum_topic_id => 2, :created_at => Time.now - 1000

			@topic2 = Factory :forum_topic, :id => 3, :forum_category_id => 1
			Factory :forum_post, :forum_topic_id => 3, :created_at => Time.now - 10000
			Factory :forum_post, :forum_topic_id => 3, :created_at => Time.now - 500
			Factory :forum_post, :forum_topic_id => 3, :created_at => Time.now - 1000
		end

		it "should order by the created at date of the last post" do
			@forum_category.topics_by_last_post.should == [@topic3, @topic2, @topic1]
		end

		it "should not include topics with no posts at the end" do
			@topic4 = Factory :forum_topic, :forum_category_id => 1
			@forum_category.topics_by_last_post.should == [@topic3, @topic2, @topic1]
		end

	end
end
