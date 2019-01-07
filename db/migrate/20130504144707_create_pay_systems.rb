# frozen_string_literal: true

class CreatePaySystems < ActiveRecord::Migration
  def change
    create_table :pay_systems do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
