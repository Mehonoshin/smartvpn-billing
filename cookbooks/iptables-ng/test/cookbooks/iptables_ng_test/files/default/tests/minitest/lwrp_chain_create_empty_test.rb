require File.expand_path('../support/helpers', __FILE__)

describe 'iptables-ng::lwrp_chain_create_empty' do
  include Helpers::TestHelpers

  it 'should create empty custom chain' do
    file('/etc/iptables.d/filter/EMPTY/default').must_include('- [0:0]')
  end

  it 'should enable iptables serices' do
    service(node['iptables-ng']['service_ipv4']).must_be_enabled if node['iptables-ng']['service_ipv4']
    service(node['iptables-ng']['service_ipv6']).must_be_enabled if node['iptables-ng']['service_ipv6']
  end

  it 'should apply the specified iptables rules' do
    ipv4 = shell_out('iptables -L -n')
    ipv4.stdout.must_include('Chain EMPTY (0 references)')

    ipv6 = shell_out('ip6tables -L -n')
    ipv6.stdout.must_include('Chain EMPTY (0 references)')
  end
end
