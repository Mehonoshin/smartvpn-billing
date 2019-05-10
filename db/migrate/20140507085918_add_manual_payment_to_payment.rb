class AddManualPaymentToPayment < ActiveRecord::Migration[5.1]
  def change
    add_column :payments, :manual_payment, :boolean, default: false
    add_column :payments, :comment, :text
  end
end
