# frozen_string_literal: true

class AddOptionAttributesToConnect < ActiveRecord::Migration
  def change
    add_column :connections, :option_attributes, :json
  end
end
