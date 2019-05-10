class AddVpnLoginAndVpnPasswordToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :vpn_login, :string
    add_column :users, :vpn_password, :string
  end
end
