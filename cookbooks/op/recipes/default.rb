package 'ntp'
package 'git'
package 'mc'
package 'vim-tiny'
package 'locales'
package 'ruby-shadow'
package 'htop'

execute "Install ruby-shadow gem for password" do
  command "gem install ruby-shadow"
end

#execute "Clear authorized keys" do
  #command "touch /root/.ssh/authorized_keys && echo '' > /root/.ssh/authorized_keys"
  ##command "echo '' > /home/vagrant/.ssh/authorized_keys"
#end

#execute "Add id_rsa to user" do
  #command "echo #{node[:chef_user][:id_rsa]} >> /root/.ssh/authorized_keys"
  ##command "echo #{node[:chef_user][:id_rsa]} >> /home/vagrant/.ssh/authorized_keys"
#end

## Create chef user
users = [
  node[:chef_user],
  node[:deploy_user]
]

users.each do |user|
  user_name = user[:username]
  user_group = user[:group]
  user_password_hash = user[:encoded_password]
  user_id_rsa = user[:id_rsa]

  group user_group do
    action :create
  end

  user user_name do
    comment "generated user"
    gid user_group
    home "/home/#{user_name}"
    shell "/bin/bash"
    password user_password_hash
  end

  directory "/home/#{user_name}" do
    owner user_name
    group user_group
  end

  execute "set ruby version for user" do
    command "echo '#{node['smartvpn']['current_ruby_version']}' > /home/#{user_name}/.ruby-version"
  end

  directory "/home/#{user_name}/.ssh" do
    action :create
    owner user_name
    group user_group
    mode "700"
    recursive true
  end

  file "/home/#{user_name}/.ssh/authorized_keys" do
    owner user_name
    action :create_if_missing
  end

  execute "Clear authorized keys" do
    command "echo "" > /home/#{user_name}/.ssh/authorized_keys"
  end

  execute "Add id_rsa to user" do
    command "echo #{user_id_rsa} >> /home/#{user_name}/.ssh/authorized_keys"
  end

  execute "generate ssh keys for #{user_name}." do
    user user_name
    creates "/home/#{user_name}/.ssh/id_rsa.pub"
    command "ssh-keygen -t rsa -q -f /home/#{user_name}/.ssh/id_rsa -P \"\""
  end
end
