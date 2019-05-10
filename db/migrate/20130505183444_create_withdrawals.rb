class CreateWithdrawals < ActiveRecord::Migration[5.1]
  def change
    create_table :withdrawals do |t|
      t.decimal :amount
      t.integer :user_id
      t.integer :plan_id

      t.timestamps
    end
  end
end
