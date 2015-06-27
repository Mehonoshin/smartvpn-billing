include_recipe "apt"

apt_repository "tor" do
  uri "http://deb.torproject.org/torproject.org"
  distribution node["lsb"]["codename"]
  components ["main"]
  keyserver "keys.gnupg.net"
  key "886DDD89"
end

%w(tor tor-arm ruby1.9.1 ruby1.9.1-dev).each do |p|
  package p do
    action :upgrade
  end
end

template "/etc/tor/torrc" do
  source "torrc.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[tor]"
end

service "tor" do
  supports [:restart, :reload, :status]
  action [:enable, :start]
end

bash "install proxymachine" do
  code "gem install proxymachine"
end

template "/opt/tor-dns-proxy.rb" do
  source "proxy.rb.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, "service[tor-dns-proxy]"
end

template "/etc/init.d/tor-dns-proxy" do
  source "tor-dns-proxy.erb"
  mode "0755"
end

service "tor-dns-proxy" do
  provider Chef::Provider::Service::Init::Debian
  supports [:restart, :reload, :status]
  action [:start]
end
