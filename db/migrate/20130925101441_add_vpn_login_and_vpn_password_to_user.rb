# frozen_string_literal: true

class AddVpnLoginAndVpnPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :vpn_login, :string
    add_column :users, :vpn_password, :string
  end
end
