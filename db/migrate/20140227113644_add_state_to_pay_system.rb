class AddStateToPaySystem < ActiveRecord::Migration
  def change
    add_column :pay_systems, :state, :string
  end
end
