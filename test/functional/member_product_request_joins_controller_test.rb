require 'test_helper'

class MemberProductRequestJoinsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:member_product_request_joins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member_product_request_join" do
    assert_difference('MemberProductRequestJoin.count') do
      post :create, :member_product_request_join => { }
    end

    assert_redirected_to member_product_request_join_path(assigns(:member_product_request_join))
  end

  test "should show member_product_request_join" do
    get :show, :id => member_product_request_joins(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => member_product_request_joins(:one).to_param
    assert_response :success
  end

  test "should update member_product_request_join" do
    put :update, :id => member_product_request_joins(:one).to_param, :member_product_request_join => { }
    assert_redirected_to member_product_request_join_path(assigns(:member_product_request_join))
  end

  test "should destroy member_product_request_join" do
    assert_difference('MemberProductRequestJoin.count', -1) do
      delete :destroy, :id => member_product_request_joins(:one).to_param
    end

    assert_redirected_to member_product_request_joins_path
  end
end
