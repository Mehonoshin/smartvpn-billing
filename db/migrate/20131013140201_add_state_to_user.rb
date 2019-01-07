# frozen_string_literal: true

class AddStateToUser < ActiveRecord::Migration
  def change
    add_column :users, :state, :string
  end
end
