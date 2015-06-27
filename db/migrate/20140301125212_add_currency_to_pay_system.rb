class AddCurrencyToPaySystem < ActiveRecord::Migration
  def change
    add_column :pay_systems, :currency, :string, default: 'usd'
  end
end
