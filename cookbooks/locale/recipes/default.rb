#
# Cookbook Name:: locale
# Recipe:: default
#
# Copyright 2011, Heavy Water Software Inc.
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

if platform?("ubuntu", "debian")

  package "locales" do
    action :install
  end

  execute "Update locale" do
    command "update-locale LANG=#{node[:locale][:lang]}"
    command "update-locale LC_CTYPE=#{node[:locale][:lang]}"
    command "update-locale LC_ALL=#{node[:locale][:lang]}"
  end

end

if platform?("redhat", "centos", "fedora")

  execute "Update locale" do
    command "locale -a | grep ^#{node[:locale][:lang]}$ && sed -i 's|LANG=.*|LANG=#{node[:locale][:lang]}|' /etc/sysconfig/i18n"
  end

end

