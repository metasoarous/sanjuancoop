require 'test_helper'

class EventCategoriesControllerTest < ActionController::TestCase
	test "should get index" do
		get :index
		assert_response :success
		assert_not_nil assigns(:event_categories)
	end

	test "should get new" do
		get :new
		assert_response :success
	end

	test "should create event_category" do
		assert_difference('EventCategory.count') do
			post :create, :event_category => { }
		end

		assert_redirected_to event_category_path(assigns(:event_category))
	end

	test "should show event_category" do
		get :show, :id => event_categories(:one).to_param
		assert_response :success
	end

	test "should get edit" do
		get :edit, :id => event_categories(:one).to_param
		assert_response :success
	end

	test "should update event_category" do
		put :update, :id => event_categories(:one).to_param, :event_category => { }
		assert_redirected_to event_category_path(assigns(:event_category))
	end

	test "should destroy event_category" do
		assert_difference('EventCategory.count', -1) do
			delete :destroy, :id => event_categories(:one).to_param
		end

		assert_redirected_to event_categories_path
	end
end
