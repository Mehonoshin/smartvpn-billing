class AddReflinkToUser < ActiveRecord::Migration
  def change
    add_column :users, :reflink, :string
  end
end
