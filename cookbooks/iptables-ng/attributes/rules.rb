#
# Cookbook Name:: iptables-ng
# Attributes:: default-rules
#
# Copyright 2012, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Set up default rules
default['iptables-ng']['rules']['filter']['INPUT']['1-ssh']['rule'] = '-p tcp -m tcp --dport 22 -j ACCEPT'
default['iptables-ng']['rules']['filter']['INPUT']['2-http']['rule'] = '-p tcp -m tcp --dport 80 -j ACCEPT'
default['iptables-ng']['rules']['filter']['INPUT']['3-https']['rule'] = '-p tcp -m tcp --dport 443 -j ACCEPT'
default['iptables-ng']['rules']['filter']['INPUT']['4-redis']['rule'] = '-p tcp -m tcp -d 127.0.0.1 -s 127.0.0.1 --dport 6379 -j ACCEPT'
default['iptables-ng']['rules']['filter']['INPUT']['5-icmp-income']['rule'] = '-p icmp --icmp-type 8 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT'
default['iptables-ng']['rules']['filter']['INPUT']['6-icmp-response']['rule'] = '-p icmp --icmp-type 0 -m state --state ESTABLISHED,RELATED -j ACCEPT'
default['iptables-ng']['rules']['filter']['INPUT']['30-established']['rule'] = '-m state --state ESTABLISHED,RELATED -j ACCEPT'
default['iptables-ng']['rules']['filter']['INPUT']['40-other']['rule'] = '-j DROP'


default['iptables-ng']['rules']['filter']['INPUT']['default'] = 'ACCEPT [0:0]'
default['iptables-ng']['rules']['filter']['OUTPUT']['default'] = 'ACCEPT [0:0]'
default['iptables-ng']['rules']['filter']['FORWARD']['default'] = 'ACCEPT [0:0]'

default['iptables-ng']['rules']['nat']['OUTPUT']['default'] = 'ACCEPT [0:0]'
default['iptables-ng']['rules']['nat']['PREROUTING']['default'] = 'ACCEPT [0:0]'
default['iptables-ng']['rules']['nat']['POSTROUTING']['default'] = 'ACCEPT [0:0]'

default['iptables-ng']['rules']['mangle']['INPUT']['default'] = 'ACCEPT [0:0]'
default['iptables-ng']['rules']['mangle']['OUTPUT']['default'] = 'ACCEPT [0:0]'
default['iptables-ng']['rules']['mangle']['FORWARD']['default'] = 'ACCEPT [0:0]'
default['iptables-ng']['rules']['mangle']['PREROUTING']['default'] = 'ACCEPT [0:0]'
default['iptables-ng']['rules']['mangle']['POSTROUTING']['default'] = 'ACCEPT [0:0]'

default['iptables-ng']['rules']['raw']['OUTPUT']['default'] = 'ACCEPT [0:0]'
default['iptables-ng']['rules']['raw']['PREROUTING']['default'] = 'ACCEPT [0:0]'
