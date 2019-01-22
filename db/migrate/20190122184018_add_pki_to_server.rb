class AddPkiToServer < ActiveRecord::Migration
  def change
    add_column :servers, :server_crt, :text
    add_column :servers, :client_crt, :text
    add_column :servers, :client_key, :text
  end
end
