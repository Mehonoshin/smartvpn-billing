#
# Cookbook Name:: redis
# Recipe:: _server_install_from_package

case node.platform_family
when "debian"
  pkg = node.redis.package_name
when "rhel", "fedora"
  include_recipe "yum::epel"
  pkg = "redis"
else
  pkg = "redis"
end

execute "install redis-server from backports" do
  command "apt-get -t wheezy-backports install redis-server -y"
  not_if "dpkg-query -W redis-server"
end
