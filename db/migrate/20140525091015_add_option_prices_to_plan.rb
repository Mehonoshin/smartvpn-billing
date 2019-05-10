class AddOptionPricesToPlan < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :option_prices, :hstore
  end
end
