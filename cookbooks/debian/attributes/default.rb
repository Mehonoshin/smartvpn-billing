#
# Cookbook Name:: debian
# Attributes:: default
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

default['debian']['mirror']                  = "http://http.debian.net/debian"
default['debian']['backports_mirror']        = "http://http.debian.net/debian"
default['debian']['components']              = %w[main contrib non-free]
default['debian']['deb_src']                 = false

# Whether to include the recipes by default recipe
default['debian']['backports']               = true
default['debian']['backports_sloppy']        = true
default['debian']['security']                = true
default['debian']['stable_proposed_updates'] = false
default['debian']['stable_updates']          = true
default['debian']['testing']                 = false
default['debian']['unstable']                = false

default['debian']['codename'] = Chef::Debian::Helpers.codename(node)
