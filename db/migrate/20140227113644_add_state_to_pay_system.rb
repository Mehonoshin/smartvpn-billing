class AddStateToPaySystem < ActiveRecord::Migration[5.1]
  def change
    add_column :pay_systems, :state, :string
  end
end
