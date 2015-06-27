cookbook_file "/etc/openvpn/any_proxy" do
  source "any_proxy"
  mode 755
end

file '/var/log/any_proxy.log' do
  mode "755"
  action :create_if_missing
end

execute 'set chmod on any_proxy.log' do
  command 'chmod 777 /var/log/any_proxy.log'
end
