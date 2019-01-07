# frozen_string_literal: true

class AddTunnelblickBundleAndIosBundleAndLinuxBundleToServer < ActiveRecord::Migration
  def change
    add_column :servers, :tunnelblick_bundle, :string
    add_column :servers, :ios_bundle, :string
    add_column :servers, :linux_bundle, :string
  end
end
