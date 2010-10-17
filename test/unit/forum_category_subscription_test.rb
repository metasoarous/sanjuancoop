require 'test_helper'

class ForumCategorySubscriptionTest < ActiveSupport::TestCase
  def test_should_not_create_many_subscriptions_for_given_cat_and_member
    member = create_member(:first_name => "Bob", :last_name => "Johnson")
    member.save
    old_subs = member.forum_category_subscriptions
    new_sub = ForumCategorySubscription.new(:member_id => member.id, :forum_category_id => 1, :frequency => "weekly")
    new_sub.save
    subs = member.forum_category_subscriptions
    assert !subs.include?(new_sub), 
            "New subscription should not have been found in members subscriptions"
    assert subs.size == old_subs.size, 
            "Subscription number should have been the same as the size as it was just after creating the member"
  end
  
  def test_should_not_create_subscription_without_member_id
    test_should_not_create_subscription_without(:member_id)
  end
  
  def test_should_not_create_subscription_without_forum_category_id
    test_should_not_create_subscription_without(:forum_category_id)
  end
  
  def test_should_not_create_subscription_without_frequency
    test_should_not_create_subscription_without(:frequency)
  end
  
  def test_should_create_harmless_subscription
    sub = create_subscription
    sub.save
    assert ForumCategorySubscription.all.include? sub
  end
  
  protected 
    def create_subscription(options = {})
      params = {:member_id => 4, :forum_category_id => 1, :frequency => "weekly", :active => false}
      return ForumCategorySubscription.new(params.merge(options))
    end
    
    def test_should_not_create_subscription_without(attribute)
      old_subs = ForumCategorySubscription.all
      sub = create_subscription(attribute => nil)
      sub.save
      new_subs = ForumCategorySubscription.all
      assert_equal new_subs, old_subs, "The Subscription collection shoud remain the same"
      assert !new_subs.include?(sub), "The new subscription should not have been included in the collection"
      assert sub.errors.on(attribute), "Should get an error message"
    end
end
