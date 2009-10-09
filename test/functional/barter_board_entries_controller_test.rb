require 'test_helper'

class BarterBoardEntriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:barter_board_entries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create barter_board_entry" do
    assert_difference('BarterBoardEntry.count') do
      post :create, :barter_board_entry => { }
    end

    assert_redirected_to barter_board_entry_path(assigns(:barter_board_entry))
  end

  test "should show barter_board_entry" do
    get :show, :id => barter_board_entries(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => barter_board_entries(:one).to_param
    assert_response :success
  end

  test "should update barter_board_entry" do
    put :update, :id => barter_board_entries(:one).to_param, :barter_board_entry => { }
    assert_redirected_to barter_board_entry_path(assigns(:barter_board_entry))
  end

  test "should destroy barter_board_entry" do
    assert_difference('BarterBoardEntry.count', -1) do
      delete :destroy, :id => barter_board_entries(:one).to_param
    end

    assert_redirected_to barter_board_entries_path
  end
end
