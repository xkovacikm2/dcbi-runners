require 'test_helper'

class RunsControllerTest < ActionController::TestCase

  def setup
    @user1 = users :has_runs
    @user2 = users :no_runs
    @run = runs :one
  end

  test 'should redirect index when not logged in' do
    get :index
    assert_redirected_to new_user_session_url
  end

  test 'should not change foreign run' do
    sign_in @user2
    assert_no_difference 'Run.find_by(id: 1).distance' do
      post :update, params: {name: '1-distance', value: '666', pk: 1, id: 1}
    end
  end

  test 'should change own run' do
    sign_in @user1
    assert_difference 'Run.find_by(id: 1).distance', 666-Run.find_by(id: 1).distance do
      post :update, params: {name: '1-distance', value: '666', pk: 1, id: 1}
    end
  end

  test 'should not delete foreign run' do
    sign_in @user2
    assert_no_difference 'Run.count' do
      delete :destroy, params: {id: @run.id}
    end
  end

  test 'should delete own run' do
    sign_in @user1
    assert_difference 'Run.count', -1 do
      delete :destroy, params: {id: @run.id}
    end
  end

  test 'should not create run for not logged in user' do

  end

  test 'should create run for signed in user' do

  end

  test 'should not create run if invalid values' do

  end
end
