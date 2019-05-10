class AddCurrencyToPaySystem < ActiveRecord::Migration[5.1]
  def change
    add_column :pay_systems, :currency, :string, default: 'usd'
  end
end
