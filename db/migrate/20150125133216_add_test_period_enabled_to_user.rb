class AddTestPeriodEnabledToUser < ActiveRecord::Migration
  def change
    add_column :users, :period_length, :integer
  end
end
