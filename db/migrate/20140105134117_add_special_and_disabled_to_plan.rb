# frozen_string_literal: true

class AddSpecialAndDisabledToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :special, :boolean, default: false
    add_column :plans, :enabled, :boolean, default: false
  end
end
