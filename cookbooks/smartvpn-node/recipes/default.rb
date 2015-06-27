### Bootstrapping system for chef
#
## Setting hostname
#hostname = 'aws1.smartvpn.biz'

#file '/etc/hostname' do
  #content "#{hostname}\n"
#end

#file '/etc/hosts' do
  #content "127.0.0.1 localhost #{hostname}\n"
#end
#
package 'ruby-shadow'
package 'build-essential'

## Create chef user
chef_user_name = node[:chef_user][:username]
chef_user_group = node[:chef_user][:group]

group node[:chef_user][:group] do
  action :create
end

user chef_user_name do
  comment "devop"
  gid "devops"
  home "/home/#{chef_user_name}"
  shell "/bin/bash"
  password node[:chef_user][:encoded_password]
end

directory "/home/#{chef_user_name}" do
  owner chef_user_name
  group chef_user_group
end

directory "/home/#{chef_user_name}/.ssh" do
  action :create
  owner chef_user_name
  group chef_user_group
  mode "700"
  recursive true
end

file "/home/#{chef_user_name}/.ssh/authorized_keys" do
  owner chef_user_name
  action :create_if_missing
end

execute "Clear authorized keys" do
  command "echo "" > /home/#{chef_user_name}/.ssh/authorized_keys"
end

execute "Add id_rsa to user" do
  command "echo #{node[:chef_user][:id_rsa]} >> /home/#{chef_user_name}/.ssh/authorized_keys"
end

package 'git'
package 'mc'
package 'vim-tiny'
