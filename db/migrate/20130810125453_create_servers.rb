class CreateServers < ActiveRecord::Migration[5.1]
  def change
    create_table :servers do |t|
      t.string :hostname
      t.string :ip_address
      t.string :auth_key
      t.string :state
      t.integer :plan_id

      t.timestamps
    end
    add_index 'servers', ['hostname'], name: 'index_servers_on_hostname', unique: true
  end
end
