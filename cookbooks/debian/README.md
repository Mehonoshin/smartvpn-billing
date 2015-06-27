Debian Cookbook [![Build Status](https://travis-ci.org/reaktor/chef-debian.png?branch=master)](https://travis-ci.org/reaktor/chef-debian)
===============

Table of Contents
-----------------

* [Description](#description)
* [Requirements](#requirements)
* [Recipes](#recipes)
* [Attributes](#attributes)
* [Resources and Providers](#resources-and-providers)
* [Usage](#usage)
* [License and Author](#license-and-author)

Description
-----------

Chef cookbook for managing Apt sources for official Debian repositories.

This cookbook can be used to configure the whole system for all the wanted
sources (stable, security, stable-updates, etc.). Just including the "default"
recipe to the run list gives a sensible default.

Individual recipes can also be used by other cookbooks that need packages for
example from the backports repository.

Requirements
------------

Intended for use in Debian, but could be modified for other Apt based platforms.
Tested on Debian 6.0 Squeeze and Debian 7 Wheezy.

Requires [apt](http://community.opscode.com/cookbooks/apt) community cookbook.

Recipes
-------

The `default` recipe configures _/etc/apt/sources.list_ using the mirror and
components specified by node attributes. It also includes other recipes if
specified via [node attributes](#attributes).

The other recipes configure apt to use the corresponding Debian repository:

  * `backports` - Sets up apt source for [Debian Backports]
    (http://wiki.debian.org/Backports) repository.
  * `backports_sloppy` - Sets up apt source for [Debian Backports/sloppy]
    (http://backports.debian.org/Instructions/#index4h2) repository. Only
    supported on Squeeze. Also includes the `backports` recipe.
  * `security` - Sets up apt source for [Debian Security Updates]
    (http://www.debian.org/security/) repository.
  * `sid` - Alias for `unstable` recipe.
  * `stable_proposed_updates` - Sets up apt source for [Debian
    stable-proposed-updates](http://wiki.debian.org/StableProposedUpdates)
    repository and includes `stable_updates` recipe.
  * `stable_updates` - Sets up apt source for [Debian stable-updates]
    (http://wiki.debian.org/StableUpdates) repository.
  * `testing` - Sets up apt source for [Debian "testing"]
    (http://www.debian.org/releases/testing/) repository with pin priority 50.
  * `unstable` - Sets up apt source for [Debian "unstable"]
    (http://www.debian.org/releases/unstable/) repository with pin priority 40.

Attributes
----------

Attribute                      | Description                    | Default
-------------------------------|--------------------------------|----------
`node['debian']['mirror']`     | Default Debian mirror URI      | `"http://http.debian.net/debian"`
`node['debian']['backports_mirror']` | Mirror URI for backports repository | `node['debian']['mirror']` (on Squeeze derived from it)
`node['debian']['components']` | Default repository components  | `["main", "contrib", "non-free"]`
`node['debian']['deb_src']`    | If true, enables apt source lines by default | false

The following attributes specify if the corresponding recipe/repository is
included by the default recipe:

Attribute                                   | Default
--------------------------------------------|--------
`node['debian']['backports']`               | false
`node['debian']['backports_sloppy']`        | false
`node['debian']['security']`                | true
`node['debian']['stable_proposed_updates']` | false
`node['debian']['stable_updates']`          | true
`node['debian']['testing']`                 | false
`node['debian']['unstable']`                | false

Resources and Providers
-------------------

### debian_repository

Sets up Debian repository and optionally pinning preferences using
`apt_repository` LWRP. This is used internally by the recipes, but feel free
if you find usage for it in your own cookbooks.

Attribute parameters:

  * `repo_name` - Name_attribute. The name of the repository and configuration
    files.
  * `uri` - The base URI of the repository. Defaults to `node['debian']['mirror']`.
  * `distribution` - Name attribute. The distribution part of apt source line.
  * `components` - The components part of apt source line. Defaults to
    `node['debian']['components']`.
  * `deb_src` - If true, enables apt source line too. Defaults to
    `node['debian']['deb_src']`.
  * `pin_priority` - The default pinning priority for the repository. Defaults
    to nil which means that no preferences are set.

Example:

```ruby
# feel the history
debian_repository "woody" do
  uri "http://archive.debian.org/debian"
  pin_priority 200
end
```

Usage
-----

If you want to manage `/etc/apt/souces.list` with Chef, add the default recipe
to the run list, preferably as the first one. The default recipe also includes
"apt::default" recipe, so you don't need to add it.

Then you can also specify which additional repositories are configured by
setting `node['debian']['<repo>']` attributes to true or false. By default
a standard set is included. The other option is to add the wanted repositories
(e.g. `recipe[debian::backports]`) directly to the run list.

The default base URI (http.debian.net) should be fine for most cases as it
redirects to a geographically closest mirror. You can also to set it explicitly
for example in a role:

```ruby
default_attributes(
  :debian => {
    :mirror => "http://ftp.fi.debian.org/debian"
  }
)
```

Other cookbooks that need packages from a specific repository should depend on
this cookbook, include the corresponding repository recipe and possibly add
apt-pinning rules for the packages as needed. Example:

```ruby
# configure backports.debian.org
include_recipe "debian::backports"

# set apt-pinning rules
%w[thepackage and some dependencies].each do |pkg|
  apt_preference pkg do
    pin "release o=Debian Backports"
    pin_priority "700"
  end
end

# install the package
package "thepackage"
```

License and Author
------------------

Author:: Teemu Matilainen <<teemu.matilainen@reaktor.fi>>

Copyright © 2011-2013, [Reaktor Innovations Oy](http://reaktor.fi/en)

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).
