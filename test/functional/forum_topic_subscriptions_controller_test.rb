require 'test_helper'

class ForumTopicSubscriptionsControllerTest < ActionController::TestCase

  test "should create forum_topic_subscription" do
    ForumTopicSubscription.any_instance.expects(:save).returns(true)
    post :create, :forum_topic_subscription => { }
    assert_response :redirect
  end

  test "should handle failure to create forum_topic_subscription" do
    ForumTopicSubscription.any_instance.expects(:save).returns(false)
    post :create, :forum_topic_subscription => { }
    assert_template "new"
  end

  test "should destroy forum_topic_subscription" do
    ForumTopicSubscription.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => forum_topic_subscriptions(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy forum_topic_subscription" do
    ForumTopicSubscription.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => forum_topic_subscriptions(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for forum_topic_subscription" do
    get :edit, :id => forum_topic_subscriptions(:one).to_param
    assert_response :success
  end

  test "should get index for forum_topic_subscriptions" do
    get :index
    assert_response :success
    assert_not_nil assigns(:forum_topic_subscriptions)
  end

  test "should get new for forum_topic_subscription" do
    get :new
    assert_response :success
  end

  test "should get show for forum_topic_subscription" do
    get :show, :id => forum_topic_subscriptions(:one).to_param
    assert_response :success
  end

  test "should update forum_topic_subscription" do
    ForumTopicSubscription.any_instance.expects(:save).returns(true)
    put :update, :id => forum_topic_subscriptions(:one).to_param, :forum_topic_subscription => { }
    assert_response :redirect
  end

  test "should handle failure to update forum_topic_subscription" do
    ForumTopicSubscription.any_instance.expects(:save).returns(false)
    put :update, :id => forum_topic_subscriptions(:one).to_param, :forum_topic_subscription => { }
    assert_template "edit"
  end

end