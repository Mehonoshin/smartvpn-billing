iptables_ng_rule 'http' do
  rule   '--protocol tcp --dport 80 --match state --state NEW --jump ACCEPT'
  action :create
end

iptables_ng_rule 'http' do
  rule   '--protocol tcp --dport 80 --match state --state NEW --jump ACCEPT'
  action :delete
end
