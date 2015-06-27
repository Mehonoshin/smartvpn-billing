iptables_ng_rule 'ssh' do
  # use defaults
  rule   '--protocol tcp --dport 22 --match state --state NEW --jump ACCEPT'
end
