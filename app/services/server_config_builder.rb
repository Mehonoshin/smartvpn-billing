# frozen_string_literal: true

# This class created connection vpn config file by server from template
class ServerConfigBuilder
  attr_accessor :server

  def initialize(server:)
    @server = server
  end

  def to_text
    erb_render_sample_config
  end

  private

  def erb_render_sample_config
    ERB.new(sample_config).result(binding)
  end

  def sample_config
    @sample_config ||= File.read(sample_config_path)
  end

  def sample_config_path
    Settings.servers.sample_config_path
  end
end
