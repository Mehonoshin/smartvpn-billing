class AddStateToPromo < ActiveRecord::Migration
  def change
    add_column :promos, :state, :string
  end
end
