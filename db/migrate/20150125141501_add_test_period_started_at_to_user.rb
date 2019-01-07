# frozen_string_literal: true

class AddTestPeriodStartedAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :test_period_started_at, :datetime
  end
end
