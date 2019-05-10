class AddStateToOption < ActiveRecord::Migration[5.1]
  def change
    add_column :options, :state, :string
  end
end
