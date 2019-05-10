class AddReferrerIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :referrer_id, :integer
  end
end
