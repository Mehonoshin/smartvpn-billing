class CreateProxyNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :proxy_nodes do |t|
      t.string :host
      t.integer :port
      t.string :country
      t.string :location
      t.integer :ping
      t.integer :bandwidth
      t.string :protocol
      t.string :anonymity

      t.timestamps
    end
  end
end
