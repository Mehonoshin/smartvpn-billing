iptables_ng_rule 'custom-chain-invalid-output' do
  chain  'FOO!'
  table  'nat'
  rule   '--protocol icmp --jump ACCEPT'
  action :create
end
