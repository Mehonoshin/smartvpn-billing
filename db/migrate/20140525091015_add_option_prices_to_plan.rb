# frozen_string_literal: true

class AddOptionPricesToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :option_prices, :hstore
  end
end
