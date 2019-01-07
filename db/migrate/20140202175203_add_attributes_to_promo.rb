# frozen_string_literal: true

class AddAttributesToPromo < ActiveRecord::Migration
  def up
    execute 'CREATE EXTENSION hstore'
    add_column :promos, :attrs, :hstore
  end

  def down
    remove_column :promos, :attrs
  end
end
