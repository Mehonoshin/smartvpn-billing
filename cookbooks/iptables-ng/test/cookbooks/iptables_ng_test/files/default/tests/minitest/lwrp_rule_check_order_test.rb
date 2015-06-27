require File.expand_path('../support/helpers', __FILE__)

describe 'iptables-ng::lwrp_rule_check_order' do
  include Helpers::TestHelpers

  it 'should concatinate iptables rules in specified order' do
    file(node['iptables-ng']['script_ipv4']).must_match(/--sport 110.*--dport 20.*--dport 50.*--dport 51.*--dport 998.*--dport 99/m)
  end
end
