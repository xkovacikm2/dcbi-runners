require 'test_helper'

class RunTest < ActiveSupport::TestCase
  def setup
    @user1 = users :has_runs
    @user2 = users :no_runs
    @valid_params = {distance: 20, duration: 500, date: Date.yesterday}
    @run = @user2.runs.new @valid_params
  end

  test 'should create valid run' do
    create_run = proc {@user1.runs.create @valid_params}
    assert_difference 'Run.count', 1, 'Run count', &create_run
    assert_difference '@user1.runs.count', 1, 'Users run count', &create_run
    assert_no_difference '@user2.runs.count','Create run for another user', &create_run
  end

  test 'should destroy run' do
    assert_difference 'Run.count', -1 do
      Run.first.destroy
    end
  end

  test 'should be valid' do
    assert @run.valid?, 'with valid params'
  end

  test 'date should be of type Date' do
    @run.date = 'topkek'
    assert_not @run.valid?
  end

  test 'date should be from past or today' do
    @run.date = Date.today
    assert @run.valid?, 'today date'

    @run.date = 5.years.ago
    assert @run.valid?, 'past date'

    @run.date = 2.days.from_now
    assert_not @run.valid? 'future date'
  end

  test 'distance is number greater than zero' do
    @run.distance = 50
    assert @run.valid?, '50 distance'

    @run.distance = 0
    assert_not @run.valid?, '0 distance'

    @run.distance = -5
    assert_not @run.valid?, '-5 distance'
  end

  test 'duration is number greater than zero' do
    @run.duration = 50
    assert @run.valid?, '50 duration'

    @run.duration = 0
    assert_not @run.valid?, '0 duration'

    @run.duration = -5
    assert_not @run.valid?, '-5 duration'
  end
end
