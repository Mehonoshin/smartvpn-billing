# frozen_string_literal: true

class CreateOptionsUsers < ActiveRecord::Migration
  def change
    create_table :options_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :option
    end
  end
end
