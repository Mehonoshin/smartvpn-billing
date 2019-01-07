# frozen_string_literal: true

class AddCantWithdrawCounterToUser < ActiveRecord::Migration
  def change
    add_column :users, :can_not_withdraw_counter, :integer, default: 0
  end
end
