# frozen_string_literal: true

class AddPromoIdUserIdUniquenessIndexToPromo < ActiveRecord::Migration
  def change
    add_index 'promotions', %w[user_id promo_id], unique: true
  end
end
