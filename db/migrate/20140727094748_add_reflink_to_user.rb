# frozen_string_literal: true

class AddReflinkToUser < ActiveRecord::Migration
  def change
    add_column :users, :reflink, :string
  end
end
