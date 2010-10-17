require 'test_helper'

class ContentItemsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_item" do
    assert_difference('ContentItem.count') do
      post :create, :content_item => { }
    end

    assert_redirected_to content_item_path(assigns(:content_item))
  end

  test "should show content_item" do
    get :show, :id => content_items(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => content_items(:one).to_param
    assert_response :success
  end

  test "should update content_item" do
    put :update, :id => content_items(:one).to_param, :content_item => { }
    assert_redirected_to content_item_path(assigns(:content_item))
  end

  test "should destroy content_item" do
    assert_difference('ContentItem.count', -1) do
      delete :destroy, :id => content_items(:one).to_param
    end

    assert_redirected_to content_items_path
  end
end
