class AddAttributesToPromo < ActiveRecord::Migration
  def up
    execute 'CREATE EXTENSION hstore'
    add_column :promos, :attrs, :hstore, default: {}
  end

  def down
    remove_column :promos, :attrs
  end
end
