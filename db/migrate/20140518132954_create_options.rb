# frozen_string_literal: true

class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
