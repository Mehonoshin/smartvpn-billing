# frozen_string_literal: true

class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :server_id
      t.float :traffic_in
      t.float :traffic_out
      t.string :type

      t.timestamps
    end
  end
end
