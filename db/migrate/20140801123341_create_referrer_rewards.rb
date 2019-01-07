# frozen_string_literal: true

class CreateReferrerRewards < ActiveRecord::Migration
  def change
    create_table :referrer_rewards do |t|
      t.decimal :amount
      t.integer :operation_id
      t.integer :referrer_id

      t.timestamps
    end
  end
end
