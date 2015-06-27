require File.expand_path('../support/helpers', __FILE__)

describe 'iptables-ng::lwrp_chain_create_default' do
  include Helpers::TestHelpers

  it 'should set default FORWARD policy to DROP' do
    file('/etc/iptables.d/filter/FORWARD/default').must_include('DROP [0:0]')
  end

  it 'should enable iptables serices' do
    service(node['iptables-ng']['service_ipv4']).must_be_enabled if node['iptables-ng']['service_ipv4']
    service(node['iptables-ng']['service_ipv6']).must_be_enabled if node['iptables-ng']['service_ipv6']
  end

  it 'should apply the specified iptables rules' do
    ipv4 = shell_out('iptables -L -n')
    ipv4.stdout.must_include('Chain FORWARD (policy DROP)')

    ipv6 = shell_out('ip6tables -L -n')
    ipv6.stdout.must_include('Chain FORWARD (policy DROP)')
  end
end
