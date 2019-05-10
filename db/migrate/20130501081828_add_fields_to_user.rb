class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :balance, :decimal, default: 0
    add_column :users, :plan_id, :integer
  end
end
