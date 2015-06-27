#
# Cookbook Name:: debian
# Provider:: repository
#
# Author:: Teemu Matilainen <teemu.matilainen@reaktor.fi>
#
# Copyright 2012-2013, Reaktor Innovations Oy
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

def whyrun_supported?
  true
end

def load_current_resource
  new_resource.uri(node['debian']['mirror']) if new_resource.uri.nil?
  new_resource.components(node['debian']['components']) if new_resource.components.nil?
  new_resource.deb_src(node['debian']['deb_src']) if new_resource.deb_src.nil?
end

action :add do
  repository_resource :add
  preferences_resourse(new_resource.pin_priority ? :add : :remove)
end

action :remove do
  repository_resource  :remove
  preferences_resourse :remove
end

def repository_resource(exec_action)
  r = apt_repository new_resource.repo_name do
    uri          new_resource.uri
    distribution new_resource.distribution
    components   new_resource.components
    deb_src      new_resource.deb_src
    action       :nothing
  end
  r.run_action exec_action
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end

def preferences_resourse(exec_action)
  r = apt_preference new_resource.repo_name do
    package_name "*"
    pin          "a=#{new_resource.distribution}, o=Debian"
    pin_priority new_resource.pin_priority.to_s
    action       :nothing
  end
  r.run_action exec_action
  new_resource.updated_by_last_action(true) if r.updated_by_last_action?
end
