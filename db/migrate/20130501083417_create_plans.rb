class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.string :code

      t.timestamps
    end
  end
end
