iptables_ng_rule 'custom-output' do
  chain  'OUTPUT'
  table  'nat'
  rule   '--protocol icmp --jump ACCEPT'
  action :create
end
