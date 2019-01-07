# frozen_string_literal: true

class CreateUserOptions < ActiveRecord::Migration
  def change
    create_table :user_options do |t|
      t.integer :user_id
      t.integer :option_id
      t.hstore :attrs

      t.timestamps
    end
  end
end
