site :opscode

metadata

# Lock down "apt" cookbook version on Chef 10
chef_version = `knife --version | awk '$1=="Chef:"{print $2}'`
cookbook 'apt', '~> 1.6' if chef_version =~ /^10\./
