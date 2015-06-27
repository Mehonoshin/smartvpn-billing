iptables_ng_rule 'custom-chain-toolong-output' do
  chain  'THIS_IS_WAY_TOO_LONG_FOR_AN_IPTABLES_CHAIN_NAME'
  table  'nat'
  rule   '--protocol icmp --jump ACCEPT'
  action :create
end
