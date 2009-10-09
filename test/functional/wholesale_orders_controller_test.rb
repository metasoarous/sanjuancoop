require 'test_helper'

class WholesaleOrdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wholesale_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wholesale_order" do
    assert_difference('WholesaleOrder.count') do
      post :create, :wholesale_order => { }
    end

    assert_redirected_to wholesale_order_path(assigns(:wholesale_order))
  end

  test "should show wholesale_order" do
    get :show, :id => wholesale_orders(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => wholesale_orders(:one).to_param
    assert_response :success
  end

  test "should update wholesale_order" do
    put :update, :id => wholesale_orders(:one).to_param, :wholesale_order => { }
    assert_redirected_to wholesale_order_path(assigns(:wholesale_order))
  end

  test "should destroy wholesale_order" do
    assert_difference('WholesaleOrder.count', -1) do
      delete :destroy, :id => wholesale_orders(:one).to_param
    end

    assert_redirected_to wholesale_orders_path
  end
end
