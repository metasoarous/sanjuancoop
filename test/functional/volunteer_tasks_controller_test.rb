require 'test_helper'

class VolunteerTasksControllerTest < ActionController::TestCase
	test "should get index" do
		get :index
		assert_response :success
		assert_not_nil assigns(:volunteer_tasks)
	end

	test "should get new" do
		get :new
		assert_response :success
	end

	test "should create volunteer_task" do
		assert_difference('VolunteerTask.count') do
			post :create, :volunteer_task => { }
		end

		assert_redirected_to volunteer_task_path(assigns(:volunteer_task))
	end

	test "should show volunteer_task" do
		get :show, :id => volunteer_tasks(:one).to_param
		assert_response :success
	end

	test "should get edit" do
		get :edit, :id => volunteer_tasks(:one).to_param
		assert_response :success
	end

	test "should update volunteer_task" do
		put :update, :id => volunteer_tasks(:one).to_param, :volunteer_task => { }
		assert_redirected_to volunteer_task_path(assigns(:volunteer_task))
	end

	test "should destroy volunteer_task" do
		assert_difference('VolunteerTask.count', -1) do
			delete :destroy, :id => volunteer_tasks(:one).to_param
		end

		assert_redirected_to volunteer_tasks_path
	end
end
