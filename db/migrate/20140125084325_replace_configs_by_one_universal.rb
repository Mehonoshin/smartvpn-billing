class ReplaceConfigsByOneUniversal < ActiveRecord::Migration[5.1]
  def change
    remove_column :servers, :tunnelblick_bundle
    remove_column :servers, :ios_bundle
    remove_column :servers, :linux_bundle
    add_column :servers, :config, :string
  end
end
