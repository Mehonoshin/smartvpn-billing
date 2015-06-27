package "privoxy" do
  action :upgrade
end

service "privoxy" do
  supports [:restart, :reload, :status]
  action [:enable, :start]
end

template "/etc/privoxy/config" do
  source "config.erb"
  owner "privoxy"
  group "nogroup"
  mode "0600"
  notifies :restart, "service[privoxy]"
end
