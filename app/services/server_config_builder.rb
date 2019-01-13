class ServerConfigBuilder
  attr_accessor :server

  def initialize(server)
    @server = server
  end

  def generate_config
    file.each_line do |line|
      new_line = rewrite_line(line)
      config.append_line(new_line)
    end
    File.write(tempfile.path, config)
    tempfile
  end

  def to_text
    config.to_text
  end

  private

  def config
    @config ||= ServerConfig.new
  end

  def file
    File.open(sample_config_path).read
  end

  def rewrite_line(line)
    tokens = line.strip.split(' ')
    key = tokens[0]

    if rewrite_mappings.keys.include? key
      "#{key} #{rewrite_mappings[key]}"
    else
      line
    end
  end

  def sample_config_path
    Settings.servers.sample_config_path
  end

  def rewrite_mappings
    {
      'proto' => protocol,
      'remote' => "#{host} #{port}"
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
end
