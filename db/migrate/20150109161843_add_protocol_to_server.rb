class AddProtocolToServer < ActiveRecord::Migration
  def change
    add_column :servers, :protocol, :string, default: 'udp'
  end
end
