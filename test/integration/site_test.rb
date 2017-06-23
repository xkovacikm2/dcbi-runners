require 'test_helper'

class SiteTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user1 = users :has_runs
    @user2 = users :no_runs
  end

  test 'layout links' do
    sign_in @user1

    get root_path
    assert_select 'a[href=?]', edit_user_registration_path(id: @user1.id)
    assert_select 'a[href=?]', destroy_user_session_path
  end

  test 'table should contain 2 rows' do
    sign_in @user1

    get root_path
    assert_select 'table'
    assert_select 'tr', Run.count+1 #thead has one too
  end

  test 'modal with form' do
    sign_in @user1

    get root_path
    assert_select 'button[data-target="#run-form-modal"]'
    assert_select 'div[id=run-form-modal]'
    assert_select 'form[id=new_run]'
  end

end
