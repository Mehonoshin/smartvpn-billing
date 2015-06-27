class CreateProxyConnects < ActiveRecord::Migration
  def change
    create_table :proxy_connects do |t|
      t.integer :user_id
      t.integer :proxy_id
      t.string :state

      t.timestamps
    end
  end
end
