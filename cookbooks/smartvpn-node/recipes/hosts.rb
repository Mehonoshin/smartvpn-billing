file '/etc/hostname' do
  content "#{node['smartvpn']['hostname']}\n"
end

file '/etc/hosts' do
  content "#{node['smartvpn']['api_ip']} #{node['smartvpn']['api_hostname']}\n"
end

execute "Reload hostname" do
  command "/etc/init.d/hostname.sh"
end


