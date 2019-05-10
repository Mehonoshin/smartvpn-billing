class AddTestPeriodEnabledToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :period_length, :integer
  end
end
