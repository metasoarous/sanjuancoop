require 'test_helper'

class BarterBoardCategoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:barter_board_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create barter_board_category" do
    assert_difference('BarterBoardCategory.count') do
      post :create, :barter_board_category => { }
    end

    assert_redirected_to barter_board_entries_path
  end

  test "should show barter_board_category" do
    get :show, :id => barter_board_categories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => barter_board_categories(:one).to_param
    assert_response :success
  end

  test "should update barter_board_category" do
    put :update, :id => barter_board_categories(:one).to_param, :barter_board_category => { }
    assert_redirected_to barter_board_category_path(assigns(:barter_board_category))
  end

  test "should destroy barter_board_category" do
    assert_difference('BarterBoardCategory.count', -1) do
      delete :destroy, :id => barter_board_categories(:one).to_param
    end

    assert_redirected_to barter_board_categories_path
  end
end
