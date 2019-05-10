class AddAttributesToPromo < ActiveRecord::Migration[5.1]
  def up
    execute 'CREATE EXTENSION hstore'
    add_column :promos, :attrs, :hstore
  end

  def down
    remove_column :promos, :attrs
  end
end
