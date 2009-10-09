require 'test_helper'

class DistributorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:distributors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create distributor" do
    assert_difference('Distributor.count') do
      post :create, :distributor => { }
    end

    assert_redirected_to distributor_path(assigns(:distributor))
  end

  test "should show distributor" do
    get :show, :id => distributors(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => distributors(:one).to_param
    assert_response :success
  end

  test "should update distributor" do
    put :update, :id => distributors(:one).to_param, :distributor => { }
    assert_redirected_to distributor_path(assigns(:distributor))
  end

  test "should destroy distributor" do
    assert_difference('Distributor.count', -1) do
      delete :destroy, :id => distributors(:one).to_param
    end

    assert_redirected_to distributors_path
  end
end
