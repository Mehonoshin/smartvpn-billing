class RemovePlanIdFromServer < ActiveRecord::Migration[5.1]
  def change
    remove_column :servers, :plan_id
  end
end
