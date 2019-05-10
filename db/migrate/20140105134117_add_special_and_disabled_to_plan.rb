class AddSpecialAndDisabledToPlan < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :special, :boolean, default: false
    add_column :plans, :enabled, :boolean, default: false
  end
end
