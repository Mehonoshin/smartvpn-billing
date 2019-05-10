class AddTunnelblickBundleAndIosBundleAndLinuxBundleToServer < ActiveRecord::Migration[5.1]
  def change
    add_column :servers, :tunnelblick_bundle, :string
    add_column :servers, :ios_bundle, :string
    add_column :servers, :linux_bundle, :string
  end
end
