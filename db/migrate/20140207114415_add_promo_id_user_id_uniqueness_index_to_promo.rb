class AddPromoIdUserIdUniquenessIndexToPromo < ActiveRecord::Migration
  def change
    add_index "promotions", ["user_id", "promo_id"], unique: true
  end
end
