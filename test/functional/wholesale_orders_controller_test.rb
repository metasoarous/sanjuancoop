require 'test_helper'

class WholesaleOrdersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wholesale_orders)
  end
end
