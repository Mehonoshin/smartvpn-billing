class AddStateToUserOption < ActiveRecord::Migration[5.1]
  def change
    add_column :user_options, :state, :string, default: 'enabled'
  end
end
