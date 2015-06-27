require File.expand_path('../support/helpers', __FILE__)

describe 'iptables-ng::default' do
  include Helpers::TestHelpers

  it 'should set default filter FORWARD policy to DROP' do
    file('/etc/iptables.d/filter/FORWARD/default').must_include('DROP [0:0]')
  end

  it 'should apply default filter FORWARD policy' do
    ipv4 = shell_out('iptables -L -n')
    ipv4.stdout.must_include('Chain FORWARD (policy DROP)')

    ipv6 = shell_out('ip6tables -t mangle -L -n')
    ipv6.stdout.must_include('Chain FORWARD (policy DROP)')
  end

  it 'should create iptables OUTPUT test_rule' do
    file('/etc/iptables.d/filter/OUTPUT/testrule-filter-OUTPUT-attribute-rule.rule_v4').must_include('--protocol icmp --jump ACCEPT')
  end

  it 'should create ip6tables OUTPUT test_rule' do
    file('/etc/iptables.d/filter/OUTPUT/testrule-filter-OUTPUT-attribute-rule.rule_v6').must_include('--protocol icmp --jump ACCEPT')
  end

  it 'should apply iptables OUTPUT test_rule' do
    ipv4 = shell_out('iptables -L -n')
    ipv4.stdout.must_match(/ACCEPT\s+icmp/)

    # Older RHEL (5.x) doesn't lookup protocol name for ICMP properly
    ipv6 = shell_out('ip6tables -L -n')
    ipv6.stdout.must_match(/ACCEPT\s+(icmp|1)/)
  end


  it 'should set default mangle FORARD policy to DROP' do
    file('/etc/iptables.d/mangle/FORWARD/default').must_include('DROP [0:0]')
  end

  it 'should apply default mangle FORARD policy' do
    ipv4 = shell_out('iptables -t mangle -L -n')
    ipv4.stdout.must_include('Chain FORWARD (policy DROP)')

    ipv6 = shell_out('ip6tables -t mangle -L -n')
    ipv6.stdout.must_include('Chain FORWARD (policy DROP)')
  end


  it 'should create nat POSTROUTING iptables rule' do
    file('/etc/iptables.d/nat/POSTROUTING/nat_test-nat-POSTROUTING-attribute-rule.rule_v4').must_include('--protocol tcp -j ACCEPT')
  end

  it 'should not create custom ip6tables rule for nat chain' do
    file('/etc/iptables.d/nat/POSTROUTING/nat_test-nat-POSTROUTING-attribute-rule.rule_v6').wont_exist
  end

  it 'should apply nat POSTROUTING iptables rule' do
    ipv4 = shell_out('iptables -t nat -L -n')
    ipv4.stdout.must_match(/ACCEPT\s+tcp/)
  end


  it 'should create SSH iptables rule' do
    file('/etc/iptables.d/filter/INPUT/ssh-filter-INPUT-attribute-rule.rule_v4').must_include('--protocol tcp --dport 22 --match state --state NEW --jump ACCEPT')
  end

  it 'should create SSH ip6tables rule' do
    file('/etc/iptables.d/filter/INPUT/ssh-filter-INPUT-attribute-rule.rule_v6').must_include('--protocol tcp --dport 22 --match state --state NEW --jump ACCEPT')
  end

  it 'should apply SSH iptables rule' do
    ipv4 = shell_out('iptables -L -n')
    ipv4.stdout.must_include('tcp dpt:22 state NEW')

    ipv6 = shell_out('ip6tables -L -n')
    ipv6.stdout.must_include('tcp dpt:22 state NEW')
  end


  it 'should create ipv4_only iptables rule' do
    file('/etc/iptables.d/filter/INPUT/ipv4_only-filter-INPUT-attribute-rule.rule_v4').must_include('--protocol tcp --source 1.2.3.4 --dport 123 --jump ACCEPT')
  end

  it 'should not create ipv4_only ip6tables rule' do
    file('/etc/iptables.d/filter/INPUT/ipv4_only-filter-INPUT-attribute-rule.rule_v6').wont_exist
  end

  it 'should apply ipv4_only iptables rule' do
    ipv4 = shell_out('iptables -L -n')
    ipv4.stdout.must_include('tcp dpt:123')
  end


  it 'should enable iptables serices' do
    service(node['iptables-ng']['service_ipv4']).must_be_enabled if node['iptables-ng']['service_ipv4']
    service(node['iptables-ng']['service_ipv6']).must_be_enabled if node['iptables-ng']['service_ipv6']
  end
end
