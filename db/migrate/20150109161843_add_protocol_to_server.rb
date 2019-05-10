class AddProtocolToServer < ActiveRecord::Migration[5.1]
  def change
    add_column :servers, :protocol, :string, default: 'udp'
  end
end
