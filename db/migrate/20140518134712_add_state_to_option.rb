# frozen_string_literal: true

class AddStateToOption < ActiveRecord::Migration
  def change
    add_column :options, :state, :string
  end
end
