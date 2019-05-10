class CreateWithdrawalProlongations < ActiveRecord::Migration[5.1]
  def change
    create_table :withdrawal_prolongations do |t|
      t.integer :withdrawal_id
      t.integer :days_number

      t.timestamps
    end
  end
end
