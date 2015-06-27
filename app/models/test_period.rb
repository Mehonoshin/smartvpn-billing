class TestPeriod
  def initialize(user)
    @user = user
  end

  def enable!
    @user.update(test_period_started_at: Date.current)
  end

  def disable!
    @user.update(test_period_started_at: nil)
  end

  def enabled?
    @user.test_period_started_at != nil
  end

  def test_period_until
    @user.test_period_started_at.to_date + length.days
  end

  private

  def length
    @user.period_length || User::DEFAULT_TEST_PERIOD
  end
end
