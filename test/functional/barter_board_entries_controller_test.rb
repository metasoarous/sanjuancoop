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
    entry = ""
    assert_difference('BarterBoardEntry.count') do
      entry = Factory(:barter_board_entry)
    end
    assert_response :success
    assert_redirected_to barter_board_entries_path
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
    entry = Factory(:barter_board_entry)
    put :update, :id => entry.id, :barter_board_entry => {:wanted_category => "2", :offered => "chitlins"}
    assert_redirected_to barter_board_entry_path(assigns(:barter_board_entry))
  end

  test "should destroy barter_board_entry" do
    assert_difference('BarterBoardEntry.count', -1) do
      delete :destroy, :id => barter_board_entries(:one).to_param
    end

    assert_redirected_to barter_board_entries_path
  end
end
