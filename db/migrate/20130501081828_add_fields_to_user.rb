# frozen_string_literal: true

class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :balance, :decimal, default: 0
    add_column :users, :plan_id, :integer
  end
end
