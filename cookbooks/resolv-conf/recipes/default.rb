if node['resolv-conf']['nameservers'].empty? || node['resolv-conf']['nameservers'][0].empty?
  Chef::Log.warn("#{cookbook_name}::#{recipe_name} requires that attribute ['resolv-conf']['nameservers'] is set.")
  Chef::Log.info("#{cookbook_name}::#{recipe_name} will exit to prevent a potential breaking change in /etc/resolv.conf.")
  return
else
  template "/etc/resolv.conf" do
    source "resolv.conf.erb"
    owner "root"
    group "root"
    mode 0644
    # This syntax makes the resolver sub-keys available directly
    variables node['resolv-conf']
  end
end
