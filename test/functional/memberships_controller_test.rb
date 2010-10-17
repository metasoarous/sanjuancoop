require 'test_helper'

class MembershipsControllerTest < ActionController::TestCase

  test "should create membership" do
    Membership.any_instance.expects(:save).returns(true)
    post :create, :membership => { }
    assert_response :redirect
  end

  test "should handle failure to create membership" do
    Membership.any_instance.expects(:save).returns(false)
    post :create, :membership => { }
    assert_template "new"
  end

  test "should destroy membership" do
    Membership.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => memberships(:one).to_param
    assert_not_nil flash[:notice]    
    assert_response :redirect
  end

  test "should handle failure to destroy membership" do
    Membership.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => memberships(:one).to_param
    assert_not_nil flash[:error]
    assert_response :redirect
  end

  test "should get edit for membership" do
    get :edit, :id => memberships(:one).to_param
    assert_response :success
  end

  test "should get index for memberships" do
    get :index
    assert_response :success
    assert_not_nil assigns(:memberships)
  end

  test "should get new for membership" do
    get :new
    assert_response :success
  end

  test "should get show for membership" do
    get :show, :id => memberships(:one).to_param
    assert_response :success
  end

  test "should update membership" do
    Membership.any_instance.expects(:save).returns(true)
    put :update, :id => memberships(:one).to_param, :membership => { }
    assert_response :redirect
  end

  test "should handle failure to update membership" do
    Membership.any_instance.expects(:save).returns(false)
    put :update, :id => memberships(:one).to_param, :membership => { }
    assert_template "edit"
  end

end