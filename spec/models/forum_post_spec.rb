require File.dirname(__FILE__) + '/../spec_helper'

describe ForumPost do
  before(:each) do
  end
  
  describe "creation" do
    it "should work" do
      Factory :forum_post
      ForumPost.count.should == 1
    end
  end
  
  describe "destruction" do
    # have a topic to work with
    before(:each) { @post = Factory :forum_post, :id => 1 } 
    
    it "should work" do
      @post.try(:destroy)
      ForumPost.count.should == 0
    end
  end
end