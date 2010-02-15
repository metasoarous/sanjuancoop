require File.dirname(__FILE__) + '/../spec_helper'

describe ForumTopic do
  before(:each) do
    # Hmm... Was getting existing records - wonder why
    [ForumTopic, Member, ForumPost].each {|m| m.destroy_all}
  end
  
  describe "creation" do
    it "should work" do
      Factory :forum_topic
      ForumTopic.count.should == 1
    end
  end
  
  describe "destruction" do
    # have a topic to work with
    before(:each) { @topic = Factory :forum_topic, :id => 1 } 
    
    it "should work without any posts" do
      @topic.try(:destroy)
      ForumTopic.count.should == 0
    end
    
    describe "with posts" do
      # Add a post to our topic
      before(:each) do 
        # This is annoying - we need a member for some 
        # reason because a mail notification is getting generated
        @member = Factory :member, :id => 1, :login => "joe", :email => "joe@foo.com"
        @post = Factory :forum_post, :forum_topic_id => 1, :member_id => 1
        @topic.try :destroy
      end
      
      it "should destroy topic" do 
        ForumTopic.count.should == 0
      end
      it "should dstroy post" do
        ForumPost.count.should == 0
      end
    end
  end
  
  describe "last_post_date method" do
    it "should return last post date when there are posts" do
      @topic2 = Factory :forum_topic, :id => 3, :forum_category_id => 1
      newest_date = Time.now
      Factory :forum_post, :forum_topic_id => 3, :created_at => Time.now - 10000
      Factory :forum_post, :forum_topic_id => 3, :created_at => newest_date
      Factory :forum_post, :forum_topic_id => 3, :created_at => Time.now - 1000
      
      @topic2.last_post_date.should == newest_date
    end
    
    it "should return nil when there are no posts" do
      @topic2 = Factory :forum_topic, :id => 3, :forum_category_id => 1
      @topic2.last_post_date.should == nil
    end
  end
  

end

