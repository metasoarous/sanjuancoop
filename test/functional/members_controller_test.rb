require File.dirname(__FILE__) + '/../test_helper'
require 'members_controller'

# Re-raise errors caught by the controller.
class MembersController; def rescue_action(e) raise e end; end

class MembersControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :members

  def test_should_allow_signup
    assert_difference 'Member.count' do
      create_member
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Member.count' do
      create_member(:login => nil)
      assert assigns(:member).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Member.count' do
      create_member(:password => nil)
      assert assigns(:member).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Member.count' do
      create_member(:password_confirmation => nil)
      assert assigns(:member).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Member.count' do
      create_member(:email => nil)
      assert assigns(:member).errors.on(:email)
      assert_response :success
    end
  end
  
  def test_should_sign_up_user_in_pending_state
    create_member
    assigns(:member).reload
    assert assigns(:member).pending?
  end

  
  def test_should_sign_up_user_with_activation_code
    create_member
    assigns(:member).reload
    assert_not_nil assigns(:member).activation_code
  end

  def test_should_activate_user
    assert_nil Member.authenticate('aaron', 'test')
    get :activate, :activation_code => members(:aaron).activation_code
    assert_redirected_to '/session/new'
    assert_not_nil flash[:notice]
    assert_equal members(:aaron), Member.authenticate('aaron', 'monkey')
  end
  
  def test_should_not_activate_user_without_key
    get :activate
    assert_nil flash[:notice]
  rescue ActionController::RoutingError
    # in the event your routes deny this, we'll just bow out gracefully.
  end

  def test_should_not_activate_user_with_blank_key
    get :activate, :activation_code => ''
    assert_nil flash[:notice]
  rescue ActionController::RoutingError
    # well played, sir
  end

  protected
    def create_member(options = {})
      post :create, :member => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
