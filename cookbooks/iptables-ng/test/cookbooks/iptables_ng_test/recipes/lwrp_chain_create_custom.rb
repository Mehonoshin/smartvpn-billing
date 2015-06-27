iptables_ng_chain 'FORWARD' do
  table  'mangle'
  policy 'DROP [0:0]'
  action :create
end
