#
# Cookbook Name:: iptables-ng
# Recipe:: restart_service
#
# Copyright 2013, Chris Aumann
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

# This was implemented as a internal-only provider.
# Apparently, calling a LWRP from a LWRP doesnt' really work with
# subscribes / notifies. Therefore, using this workaround.

module Iptables
  module Manage
    def restart_service(ip_version)
      # Restart iptables service if available
      if node['iptables-ng']["service_ipv#{ip_version}"]

        # Do not restart twice if the command is the same for ipv4 and ipv6
        return if node['iptables-ng']['service_ipv4'] == node['iptables-ng']['service_ipv6'] and ip_version == 6

        Chef::Resource::Service.new(node['iptables-ng']["service_ipv#{ip_version}"], run_context).tap do |service|
          service.supports(status: true, restart: true)
          service.run_action(:enable)
          service.run_action(:restart)
        end

      # If no service is available, apply the rules manually
      else
        Chef::Log.info 'applying rules manually, as no service is specified'
        Chef::Resource::Execute.new("iptables-restore for ipv#{ip_version}", run_context).tap do |execute|
          execute.command("iptables-restore < #{node['iptables-ng']['script_ipv4']}") if ip_version == 4
          execute.command("ip6tables-restore < #{node['iptables-ng']['script_ipv6']}") if ip_version == 6
          execute.run_action(:run)
        end
      end
    end
  end
end
