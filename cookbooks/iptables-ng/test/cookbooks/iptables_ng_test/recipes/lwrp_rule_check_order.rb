iptables_ng_rule '99-last' do
  rule '--protocol tcp --dport 99 --jump ACCEPT'
end

iptables_ng_rule '20-second' do
  rule '--jump ACCEPT --protocol udp --dport 20'
end

iptables_ng_rule '10-first' do
  rule '--protocol tcp --jump ACCEPT --sport 110'
end

iptables_ng_rule '51-medium-2' do
  rule '--jump ACCEPT --protocol tcp --dport 51'
end

iptables_ng_rule '50-medium-1' do
  rule '--protocol udp --dport 50 --jump ACCEPT'
end

iptables_ng_rule '98-almost-last' do
  rule '--jump ACCEPT --protocol tcp --dport 998'
end
