name "redis"
maintainer       "Miah Johnson"
maintainer_email "miah@cx.com"
license          "Apache 2.0"
description      "Installs/configures redis"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.1.1"

recipe "redis::default", "The default recipe does nothing. Used to include only the LWRP"
recipe "redis::data_bag", "The recipe to create multiple redis instances from data_bags using the LWRP."
recipe "redis::server", "The default recipe executes the redis::server_package recipe. This recipe is here for compatibility with other community Redis cookbooks."
recipe "redis::server_package", "Uses the recipe crumbs in the Redis cookbook to manage a packaged Redis instance."
recipe "redis::server_source", "Uses the recipe crumbs in the Redis cookbook to manage a source compiled Redis instance."
recipe "redis::sentinel", "Setup sentinel for monitoring cluster"

%w[ ubuntu centos ].each do |os|
  supports os
end

#yum
%w[ build-essential runit ].each do |cookbook|
  depends cookbook
end

#depends 'stunnel', '>= 2.0.0'   # replication
#depends 'discovery', '>= 0.2.0' # replication
