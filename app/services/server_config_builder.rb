class ServerConfigBuilder
  attr_accessor :config

  def initialize(server)
    @server = server
  end

  def generate_config
    file.each_line do |line|
      new_line = rewrite_line(line)
      config.append_line(new_line)
    end
    config
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
      "proto" => protocol,
      "remote" => "#{host} #{port}"
    }
  end

  def protocol
    @server.protocol
  end

  def host
    @server.hostname
  end

  def port
    @server.port
  end
end
