# frozen_string_literal: true

class Billing::ServersController < Billing::BaseController
  def index
    @servers = servers
  end

  def download_config
    @server = servers.find(params[:id])
    builder = ServerConfigBuilder.new(@server)
    config_file = builder.generate_config
    send_data config_file.to_text, filename: "#{@server.hostname}.ovpn"
  end

  private

  def servers
    current_user.plan.servers.active
  end
end
