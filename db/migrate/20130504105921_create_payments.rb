# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.decimal :amount
      t.integer :pay_system_id
      t.string :state

      t.timestamps
    end
  end
end
