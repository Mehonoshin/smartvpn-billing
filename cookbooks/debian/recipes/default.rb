#
# Cookbook Name:: debian
# Recipe:: default
#
# Author:: Teemu Matilainen <teemu.matilainen@reaktor.fi>
#
# Copyright 2011-2013, Reaktor Innovations Oy
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

unless node['platform'] == 'debian'
  Chef::Log.warn 'recipe[debian::default] included in non-Debian platform. Skipping.'
  return
end

template '/etc/apt/sources.list' do
  owner    'root'
  group    'root'
  mode     00644
  notifies :run, 'execute[apt-get update]', :immediately
end

include_recipe 'apt'

%w[backports backports_sloppy security stable_proposed_updates stable_updates testing unstable].each do |repo|
  include_recipe "debian::#{repo}" if node['debian'][repo]
end
