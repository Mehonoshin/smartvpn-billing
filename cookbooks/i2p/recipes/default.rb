include_recipe "apt"

package "ntp" do
  action :install
end

apt_repository "i2p" do
  uri "http://deb.i2p2.no/"
  distribution "stable"
  components ["main"]
  key "https://geti2p.net/_static/i2p-debian-repo.key.asc"
end

execute "Preconfigure i2p" do
  command "echo i2p i2p/daemon boolean true | debconf-set-selections"
end

%w(openjdk-7-jre-headless i2p).each do |p|
  package p do
    action :install
  end
end

cookbook_file '/var/lib/i2p/i2p-config/addressbook/subscriptions.txt' do
  source 'subscriptions.txt'
  mode 755
end

execute 'set chmod on subscriptions' do
  command 'chmod 777 /var/lib/i2p/i2p-config/addressbook/subscriptions.txt'
end

service "i2p" do
  supports restart: true
  action [:enable, :start]
end
