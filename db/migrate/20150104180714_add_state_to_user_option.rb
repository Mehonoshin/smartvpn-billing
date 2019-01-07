# frozen_string_literal: true

class AddStateToUserOption < ActiveRecord::Migration
  def change
    add_column :user_options, :state, :string, default: 'enabled'
  end
end
