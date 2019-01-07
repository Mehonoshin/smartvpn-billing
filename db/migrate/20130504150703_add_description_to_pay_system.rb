# frozen_string_literal: true

class AddDescriptionToPaySystem < ActiveRecord::Migration
  def change
    add_column :pay_systems, :description, :text
  end
end
