iptables-ng CHANGELOG
=====================

This file is used to list changes made in each version of the iptables-ng cookbook.

2.0.0
-----

- Support custom chains
- Rename/Migrate iptables_ng_policy provider to iptables_ng_chain

1.1.1
-----

- Fixes duplicate resource name warnings [CHEF-3694], Thanks [James FitzGibbon](http://github.com/jf647)

1.1.0
-----

- Support for ip_version parameter in attributes. See README for details.

  If you use attributes to configure iptables_ng, you need to migrate

  ```node['iptables-ng']['rules']['filter']['INPUT']['rej'] = 'myrule'```

  to

  ```node['iptables-ng']['rules']['filter']['INPUT']['rej']['rule'] = 'myrule'```


1.0.0
-----
- [Chris Aumann] - Initial release of iptables-ng
