class AddStateToPromo < ActiveRecord::Migration[5.1]
  def change
    add_column :promos, :state, :string
  end
end
