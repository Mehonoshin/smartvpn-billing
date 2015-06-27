require File.expand_path('../support/helpers', __FILE__)

describe 'iptables-ng::lwrp_create_custom_chain' do
  include Helpers::TestHelpers

  it 'should create the custom chain directory' do
      directory('/etc/iptables.d/nat/FOO').must_exist
  end

  it 'should set custom iptables rule' do
    file('/etc/iptables.d/nat/FOO/custom-chain-output.rule_v4').must_include('--protocol icmp --jump ACCEPT')
  end

  it 'should not set custom ip6tables rule for nat chain' do
    file('/etc/iptables.d/nat/FOO/custom-chain-output.rule_v6').wont_exist
  end

  it 'should enable iptables serices' do
    service(node['iptables-ng']['service_ipv4']).must_be_enabled if node['iptables-ng']['service_ipv4']
    service(node['iptables-ng']['service_ipv6']).must_be_enabled if node['iptables-ng']['service_ipv6']
  end

  it 'should apply the specified iptables rules' do
    ipv4 = shell_out('iptables -t nat -L -n')
    ipv4.stdout.must_match(/ACCEPT\s+icmp/)
  end
end
