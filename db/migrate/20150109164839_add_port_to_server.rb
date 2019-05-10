class AddPortToServer < ActiveRecord::Migration[5.1]
  def change
    add_column :servers, :port, :integer, default: 443
  end
end
