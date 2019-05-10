class CreatePromos < ActiveRecord::Migration[5.1]
  def change
    create_table :promos do |t|
      t.string :name
      t.string :type
      t.date :date_from
      t.date :date_to
      t.string :promoter_type
      t.string :promo_code

      t.timestamps
    end
  end
end
