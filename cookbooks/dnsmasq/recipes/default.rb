package "dnsmasq" do
  action :upgrade
end

package "resolvconf dnsutils" do
  action :install
end

service "dnsmasq" do
  supports [:restart, :reload, :status]
  action [:enable, :start]
end

template "/etc/dnsmasq.conf" do
  source "dnsmasq.conf.erb"
  owner "root"
  mode "0600"
  notifies :restart, "service[dnsmasq]"
end

template "/etc/default/dnsmasq" do
  source "default.erb"
  owner "root"
  mode "0600"
  notifies :restart, "service[dnsmasq]"
end

dns_conf_path = "/etc/resolv.conf"
dns_line = "nameserver 127.0.0.1"

execute "Set up resolv to use dnsmasq" do
  command "echo '#{dns_line}' >> #{dns_conf_path}; resolvconf -u"
  not_if { ::File.read(dns_conf_path).include?(dns_line) }
end
