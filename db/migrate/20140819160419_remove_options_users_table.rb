class RemoveOptionsUsersTable < ActiveRecord::Migration
  def change
    drop_table :options_users
  end
end
