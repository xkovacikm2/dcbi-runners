require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users :has_runs
  end

  test 'associated runs should be destroyed' do
    assert_difference 'User.count', -1 do
      @user.destroy
    end
    assert_equal 0, Run.count
  end
end
