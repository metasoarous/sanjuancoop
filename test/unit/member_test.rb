require File.dirname(__FILE__) + '/../test_helper'

class MemberTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :members

  def test_should_create_member
    assert_difference 'Member.count' do
      member = create_member
      assert !member.new_record?, "#{member.errors.full_messages.to_sentence}"
    end
  end

  def test_should_initialize_activation_code_upon_creation
    member = create_member
    member.reload
    assert_not_nil member.activation_code
  end

  def test_should_create_and_start_in_pending_state
    member = create_member
    member.reload
    assert member.pending?
  end


  def test_should_require_login
    assert_no_difference 'Member.count' do
      u = create_member(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'Member.count' do
      u = create_member(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'Member.count' do
      u = create_member(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'Member.count' do
      u = create_member(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    members(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal members(:quentin), Member.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    members(:quentin).update_attributes(:login => 'quentin2')
    assert_equal members(:quentin), Member.authenticate('quentin2', 'monkey')
  end

  def test_should_authenticate_member
    assert_equal members(:quentin), Member.authenticate('quentin', 'monkey')
  end

  def test_should_set_remember_token
    members(:quentin).remember_me
    assert_not_nil members(:quentin).remember_token
    assert_not_nil members(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    members(:quentin).remember_me
    assert_not_nil members(:quentin).remember_token
    members(:quentin).forget_me
    assert_nil members(:quentin).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    members(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil members(:quentin).remember_token
    assert_not_nil members(:quentin).remember_token_expires_at
    assert members(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    members(:quentin).remember_me_until time
    assert_not_nil members(:quentin).remember_token
    assert_not_nil members(:quentin).remember_token_expires_at
    assert_equal members(:quentin).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    members(:quentin).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil members(:quentin).remember_token
    assert_not_nil members(:quentin).remember_token_expires_at
    assert members(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_register_passive_member
    member = create_member(:password => nil, :password_confirmation => nil)
    assert member.passive?
    member.update_attributes(:password => 'new password', :password_confirmation => 'new password')
    member.register!
    assert member.pending?
  end

  def test_should_suspend_member
    members(:quentin).suspend!
    assert members(:quentin).suspended?
  end

  def test_suspended_member_should_not_authenticate
    members(:quentin).suspend!
    assert_not_equal members(:quentin), Member.authenticate('quentin', 'test')
  end

  def test_should_unsuspend_member_to_active_state
    members(:quentin).suspend!
    assert members(:quentin).suspended?
    members(:quentin).unsuspend!
    assert members(:quentin).active?
  end

  def test_should_unsuspend_member_with_nil_activation_code_and_activated_at_to_passive_state
    members(:quentin).suspend!
    Member.update_all :activation_code => nil, :activated_at => nil
    assert members(:quentin).suspended?
    members(:quentin).reload.unsuspend!
    assert members(:quentin).passive?
  end

  def test_should_unsuspend_member_with_activation_code_and_nil_activated_at_to_pending_state
    members(:quentin).suspend!
    Member.update_all :activation_code => 'foo-bar', :activated_at => nil
    assert members(:quentin).suspended?
    members(:quentin).reload.unsuspend!
    assert members(:quentin).pending?
  end

  def test_should_delete_member
    assert_nil members(:quentin).deleted_at
    members(:quentin).delete!
    assert_not_nil members(:quentin).deleted_at
    assert members(:quentin).deleted?
  end

protected
  def create_member(options = {})
    record = Member.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.register! if record.valid?
    record
  end
end
