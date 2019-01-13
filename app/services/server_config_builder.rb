# frozen_string_literal: true

class ServerConfigBuilder
  attr_accessor :server

  def initialize(server:)
    @server = server
  end

  def generate_config
    sample_config.each_line do |line|
      new_line = rewrite_line(line)
      tempfile.puts new_line
    end
    tempfile.close
    tempfile
  end

  private

  def rewrite_line(line)
    tokens = line.strip.split(' ')
    key = tokens.first&.to_sym

    return line unless rewrite_mappings.key? key

    "#{key} #{rewrite_mappings[key]}"
  end

  def sample_config_path
    Settings.servers.sample_config_path
  end

  def rewrite_mappings
    {
      proto: protocol,
      remote: "#{host} #{port}"
    }
  end

  def protocol
    @protocol ||= server.protocol
  end

  def host
    @host ||= server.hostname
  end

  def port
    @port ||= server.port
  end

  def tempfile
    @tempfile ||= Tempfile.new(%w[server-config- .ovpn])
  end

  def sample_config
    @sample_config ||= File.open(sample_config_path).read
  end
end
