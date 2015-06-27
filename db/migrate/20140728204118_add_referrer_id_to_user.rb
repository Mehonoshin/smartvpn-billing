class AddReferrerIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :referrer_id, :integer
  end
end
