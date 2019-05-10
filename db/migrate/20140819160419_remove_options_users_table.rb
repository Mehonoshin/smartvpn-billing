class RemoveOptionsUsersTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :options_users
  end
end
