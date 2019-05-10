class AddPromoIdUserIdUniquenessIndexToPromo < ActiveRecord::Migration[5.1]
  def change
    add_index 'promotions', %w[user_id promo_id], unique: true
  end
end
