#
# Cookbook Name:: openvpn
# Recipe:: default
#
# Copyright 2009-2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

routes = node['openvpn']['routes']
node.default['openvpn']['routes'] = routes.flatten

key_dir = node["openvpn"]["key_dir"]

package "openvpn" do
  action :install
end

directory key_dir do
  owner "root"
  group "root"
  mode 0700
end

directory "/etc/openvpn/easy-rsa" do
  owner "root"
  group "root"
  mode 0755
end

%w{openssl.cnf pkitool vars Rakefile}.each do |f|
  template "/etc/openvpn/easy-rsa/#{f}" do
    source "#{f}.erb"
    owner "root"
    group "root"
    mode 0755
  end
end

template "/etc/openvpn/server.up.sh" do
  source "server.up.sh.erb"
  owner "root"
  group "root"
  mode 0755
  notifies :restart, "service[openvpn]"
end

[
 "01.pem", "ca.key", "index.txt",
 "openssl.cnf", "server.crt", "server.key",
 "ca.crt", "dh1024.pem", "index.txt.attr",
 "serial", "server.csr"
].each do |filename|
  cookbook_file filename do
    path "#{key_dir}/#{filename}"
    owner "root"
    group "root"
    mode 0644
    action :create
  end
end

cookbook_file "#{key_dir}/ca.crt" do
  path "ca.crt"
  owner "root"
  group "root"
  mode 0644
  action :create
end

template "/etc/openvpn/server.conf" do
  source "server.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[openvpn]"
end

package "ruby" do
  action :install
end

package "ruby-dev" do
  action :install
end

file '/sbin/iptables' do
  mode '04755'
end

file '/etc/openvpn/openvpn-status.log' do
  mode '0755'
end

gem_package "openvpn-http-hooks" do
  source node['openvpn']['gems_source']
  action :install
  version node['openvpn']['openvpn-http-hooks-version']
end

execute "chmod-openvpn-http-hooks" do
  command "chmod -R 755 /var/lib/gems/1.9.1/gems"
end

gem_package 'em-proxy' do
  action :install
end

file '/etc/openvpn/relays.txt' do
  mode '0777'
  action :create_if_missing
end

unless File.exists?("/etc/openvpn/auth_key")
  execute "Run server activation script" do
    command "openvpn-activate"
  end
end

service "openvpn" do
  action [:enable, :start]
end
