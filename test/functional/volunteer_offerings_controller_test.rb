require 'test_helper'

class VolunteerOfferingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:volunteer_offerings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create volunteer_offering" do
    assert_difference('VolunteerOffering.count') do
      post :create, :volunteer_offering => { }
    end

    assert_redirected_to volunteer_tasks_path
  end

  test "should show volunteer_offering" do
    get :show, :id => volunteer_offerings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => volunteer_offerings(:one).to_param
    assert_response :success
  end

  test "should update volunteer_offering" do
    put :update, :id => volunteer_offerings(:one).to_param, :volunteer_offering => { }
    assert_redirected_to volunteer_tasks_path
  end

  test "should destroy volunteer_offering" do
    assert_difference('VolunteerOffering.count', -1) do
      delete :destroy, :id => volunteer_offerings(:one).to_param
    end

    assert_redirected_to volunteer_tasks_path
  end
end
