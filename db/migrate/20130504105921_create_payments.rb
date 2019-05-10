class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.decimal :amount
      t.integer :pay_system_id
      t.string :state

      t.timestamps
    end
  end
end
