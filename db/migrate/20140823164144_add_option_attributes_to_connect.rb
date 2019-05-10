class AddOptionAttributesToConnect < ActiveRecord::Migration[5.1]
  def change
    add_column :connections, :option_attributes, :json
  end
end
