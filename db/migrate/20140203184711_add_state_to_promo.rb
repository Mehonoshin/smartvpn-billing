# frozen_string_literal: true

class AddStateToPromo < ActiveRecord::Migration
  def change
    add_column :promos, :state, :string
  end
end
