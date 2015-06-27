require 'rspec/expectations'

RSpec::Matchers.define :add_apt_source do |expected, d_file = nil|
  file = "/etc/apt/sources.list"
  file << ".d/#{d_file}" if d_file

  match do |actual|
    expect(actual).to render_file(file).
      with_content(%r{^\s*#{escape_ignoring_spaces(expected)}\s*$})
  end

  failure_message_for_should do |actual|
    %Q{expected #{actual} to add "#{expected}" to #{file}}
  end

  failure_message_for_should_not do |actual|
    %Q{expected #{actual} not to add "#{expected}" to #{file}}
  end

  def escape_ignoring_spaces(s)
    Regexp.escape(s).gsub(/(\\?\s)+/, '\s+')
  end
end

RSpec::Matchers.define :add_backports_source do |expected_mirror|
  match do |actual|
    expect(actual).to add_apt_source(src_line(actual), "backports.list")
  end

  define_method :src_line do |actual|
    "deb #{expected_mirror} #{codename(actual.node)}-backports main contrib non-free"
  end

  def codename(node)
    Chef::Debian::Helpers.codename_for_platform_version(node['platform_version'])
  end
end
