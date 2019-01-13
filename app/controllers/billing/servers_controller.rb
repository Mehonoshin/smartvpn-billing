# frozen_string_literal: true

module Billing
  class ServersController < Billing::BaseController
    def index
      @servers = servers
    end

    def download_config
      @server = servers.find(params[:id])
      builder = ServerConfigBuilder.new(server: @server)
      config_file = builder.to_text
      send_data config_file, filename: "#{@server.hostname}.ovpn"
    end

    private

    def servers
      current_user.plan.servers.active
    end
  end
end
