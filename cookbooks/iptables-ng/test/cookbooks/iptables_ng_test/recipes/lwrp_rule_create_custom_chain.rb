iptables_ng_rule 'custom-chain-output' do
  chain  'FOO'
  table  'nat'
  rule   '--protocol icmp --jump ACCEPT'
  action :create
end
