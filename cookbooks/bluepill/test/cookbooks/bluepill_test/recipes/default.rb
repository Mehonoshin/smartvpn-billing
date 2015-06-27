include_recipe "bluepill"

# Boring
package "nc" do
  package_name case node['platform_family']
               when "debian"
                 "netcat"
               else
                 "nc"
               end
end

# This fake services uses Netcat to continuously send the secret
# (attribute) to the tcp_server_listen_port, which we bind in the test
template ::File.join(node['bluepill']['conf_dir'],
                     node['bluepill_test']['service_name'] + ".pill")

bluepill_service node['bluepill_test']['service_name'] do
  action [:enable, :load, :start]
end
