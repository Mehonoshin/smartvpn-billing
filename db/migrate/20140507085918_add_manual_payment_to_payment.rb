class AddManualPaymentToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :manual_payment, :boolean, default: false
    add_column :payments, :comment, :text
  end
end
