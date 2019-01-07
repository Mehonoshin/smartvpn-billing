# frozen_string_literal: true

class CreatePlanOptionTable < ActiveRecord::Migration
  def change
    create_table :options_plans, id: false do |t|
      t.belongs_to :plan
      t.belongs_to :option
    end
  end
end
