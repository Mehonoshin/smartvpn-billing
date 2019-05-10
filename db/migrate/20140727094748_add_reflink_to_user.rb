class AddReflinkToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :reflink, :string
  end
end
