class AddCantWithdrawCounterToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :can_not_withdraw_counter, :integer, default: 0
  end
end
