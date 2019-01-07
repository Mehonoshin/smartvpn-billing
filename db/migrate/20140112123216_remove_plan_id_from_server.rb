# frozen_string_literal: true

class RemovePlanIdFromServer < ActiveRecord::Migration
  def change
    remove_column :servers, :plan_id
  end
end
