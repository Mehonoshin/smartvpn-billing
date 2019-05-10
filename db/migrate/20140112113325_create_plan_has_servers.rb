class CreatePlanHasServers < ActiveRecord::Migration[5.1]
  def change
    create_table :plan_has_servers do |t|
      t.integer :server_id
      t.integer :plan_id

      t.timestamps
    end
  end
end
