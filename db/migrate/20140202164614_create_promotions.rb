class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.integer :user_id
      t.integer :promo_id

      t.timestamps
    end
  end
end
