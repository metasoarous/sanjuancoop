require 'test_helper'

class BoardMembersControllerTest < ActionController::TestCase
	test "should get index" do
		get :index
		assert_response :success
		assert_not_nil assigns(:board_members)
	end

	test "should get new" do
		get :new
		assert_response :success
	end

	test "should create board_member" do
		assert_difference('BoardMember.count') do
			post :create, :board_member => { }
		end

		assert_redirected_to board_member_path(assigns(:board_member))
	end

	test "should show board_member" do
		get :show, :id => board_members(:one).to_param
		assert_response :success
	end

	test "should get edit" do
		get :edit, :id => board_members(:one).to_param
		assert_response :success
	end

	test "should update board_member" do
		put :update, :id => board_members(:one).to_param, :board_member => { }
		assert_redirected_to board_member_path(assigns(:board_member))
	end

	test "should destroy board_member" do
		assert_difference('BoardMember.count', -1) do
			delete :destroy, :id => board_members(:one).to_param
		end

		assert_redirected_to board_members_path
	end
end
