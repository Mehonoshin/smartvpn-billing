# frozen_string_literal: true

# This class created connection vpn config file by server from template
class ServerConfigBuilder
  attr_accessor :server

  def initialize(server:)
    @server = server
  end

  def generate_config
    tempfile.puts erb_render_sample_config
    tempfile.rewind
    tempfile
  end

  def to_text
    erb_render_sample_config
  end

  private

  def erb_render_sample_config
    ERB.new(sample_config).result(binding)
  end

  def sample_config_path
    Settings.servers.sample_config_path
  end

  def tempfile
    @tempfile ||= Tempfile.new(%w[server-config- .ovpn])
  end

  def sample_config
    @sample_config ||= File.read(sample_config_path)
  end
end
