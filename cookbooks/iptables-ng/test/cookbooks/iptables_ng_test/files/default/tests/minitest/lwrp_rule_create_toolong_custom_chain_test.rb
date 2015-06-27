require File.expand_path('../support/helpers', __FILE__)

describe 'iptables-ng::lwrp_create_toolong_custom_chain' do
  include Helpers::TestHelpers

  it 'should not create a rule when the chain name is too long' do
    file('/etc/iptables.d/nat/FOO/custom-chain-toolong-output.rule_v4').wont_exist
  end

  it 'should enable iptables serices' do
    service(node['iptables-ng']['service_ipv4']).must_be_enabled if node['iptables-ng']['service_ipv4']
    service(node['iptables-ng']['service_ipv6']).must_be_enabled if node['iptables-ng']['service_ipv6']
  end

  it 'should not apply the specified iptables rules' do
    ipv4 = shell_out('iptables -t nat -L -n')
    ipv4.stdout.must_not_match(/ACCEPT\s+icmp/)
  end
end
