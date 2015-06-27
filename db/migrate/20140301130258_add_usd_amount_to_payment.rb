class AddUsdAmountToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :usd_amount, :decimal, precision: 12, scale: 2
  end
end
