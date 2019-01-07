# frozen_string_literal: true

class ServerConfig
  attr_accessor :config_lines

  def initialize
    @config_lines = []
  end

  def append_line(line)
    config_lines << line
  end

  def to_text
    config_lines.join('')
  end
end
