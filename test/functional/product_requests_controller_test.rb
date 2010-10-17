require 'test_helper'

class ProductRequestsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_request" do
    assert_difference('ProductRequest.count') do
      post :create, :product_request => { }
    end

    assert_redirected_to product_request_path(assigns(:product_request))
  end

  test "should show product_request" do
    get :show, :id => product_requests(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => product_requests(:one).to_param
    assert_response :success
  end

  test "should update product_request" do
    put :update, :id => product_requests(:one).to_param, :product_request => { }
    assert_redirected_to product_request_path(assigns(:product_request))
  end

  test "should destroy product_request" do
    assert_difference('ProductRequest.count', -1) do
      delete :destroy, :id => product_requests(:one).to_param
    end

    assert_redirected_to product_requests_path
  end
end
