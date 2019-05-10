class AddDescriptionToPaySystem < ActiveRecord::Migration[5.1]
  def change
    add_column :pay_systems, :description, :text
  end
end
