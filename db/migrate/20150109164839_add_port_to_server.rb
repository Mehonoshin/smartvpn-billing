# frozen_string_literal: true

class AddPortToServer < ActiveRecord::Migration
  def change
    add_column :servers, :port, :integer, default: 443
  end
end
