# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'date'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
DEFAULT_BOX = "debian7"
SUBNET = "192.168.33"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = DEFAULT_BOX
  config.vm.box_url = "https://dl.dropboxusercontent.com/u/5884236/vanilla-deb7.box"

  config.vm.define "dev", primary: true do |dev|
    dev.vm.network :private_network, ip: "#{SUBNET}.10"
    dev.vm.network :forwarded_port, guest: 5432, host: 5432 # pq
    dev.vm.network :forwarded_port, guest: 6379, host: 6379 # redis
    script = <<SCRIPT
      date --set #{DateTime.now.strftime('%Y-%m-%d')}
      date --set #{DateTime.now.strftime('%H:%M')}
      set -e

      DEBIAN_FRONTEND=noninteractive

      apt-get -qqy update

      PG_PKG=postgresql
      PG_INSTALLED=$(dpkg -l | grep -q ${PG_PKG} || echo "NOT")
      if [ "x${PG_INSTALLED}" = "xNOT" ] ; then

        echo 'deb http://apt.postgresql.org/pub/repos/apt/ wheezy-pgdg main' > /etc/apt/sources.list.d/pgdg.list
        wget https://www.postgresql.org/media/keys/ACCC4CF8.asc --no-check-certificate
        apt-key add ACCC4CF8.asc
        apt-get update

      echo 'Name: libraries/restart-without-asking
Template: libraries/restart-without-asking
Value: true
Owners: libssl1.0.0
Flags: seen' >> /var/cache/debconf/config.dat

        apt-get -qy install postgresql postgresql-contrib

        sed -i "s|#listen_addresses.*$|listen_addresses = '*' |g" /etc/postgresql/9.3/main/postgresql.conf
        echo "host    all             all             all               trust" > /etc/postgresql/9.3/main/pg_hba.conf
        /etc/init.d/postgresql restart
      fi

      REDIS_PKG=redis-server
      REDIS_INSTALLED=$(dpkg -l | grep -q ${REDIS_PKG} || echo "NOT")
      if [ "x${REDIS_INSTALLED}" = "xNOT" ] ; then
        apt-get -qy install $REDIS_PKG
        sed -i "s|bind 127.0.0.1|#bind = 127.0.0.1|g" /etc/redis/redis.conf
        /etc/init.d/redis-server restart
      fi

      echo DONE
SCRIPT
    dev.vm.provision :shell, inline: script
  end

  config.vm.define "stage" do |stage|
    stage.vm.network :private_network, ip: "#{SUBNET}.11"
  end

  config.vm.define "node" do |node|
    node.vm.network :private_network, ip: "#{SUBNET}.12"
  end
end
