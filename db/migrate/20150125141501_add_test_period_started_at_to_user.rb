class AddTestPeriodStartedAtToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :test_period_started_at, :datetime
  end
end
