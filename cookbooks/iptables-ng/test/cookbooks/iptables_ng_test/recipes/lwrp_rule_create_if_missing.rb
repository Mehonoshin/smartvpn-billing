iptables_ng_rule 'ssh' do
  rule   '--protocol tcp --dport 22 --match state --state NEW --jump ACCEPT'
  action :create
end

iptables_ng_rule 'ssh' do
  rule   '--protocol tcp --dport 80 --match state --state NEW --jump ACCEPT'
  action :create_if_missing
end
