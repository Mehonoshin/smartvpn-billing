require File.expand_path('../support/helpers', __FILE__)

describe 'iptables-ng::lwrp_rule_delete' do
  include Helpers::TestHelpers

  it 'should not set HTTP rule' do
    file('/etc/iptables.d/filter/INPUT/http.rule_v4').wont_exist
  end

  it 'should not set HTTP ip6tables rule' do
    file('/etc/iptables.d/filter/INPUT/http.rule_v6').wont_exist
  end

  it 'should enable iptables serices' do
    service(node['iptables-ng']['service_ipv4']).must_be_enabled if node['iptables-ng']['service_ipv4']
    service(node['iptables-ng']['service_ipv6']).must_be_enabled if node['iptables-ng']['service_ipv6']
  end

  it 'should apply the specified iptables rules' do
    ipv4 = shell_out('iptables -L -n')
    ipv4.stdout.wont_include('tcp dpt:80 state NEW')

    ipv6 = shell_out('ip6tables -L -n')
    ipv6.stdout.wont_include('tcp dpt:80 state NEW')
  end
end
