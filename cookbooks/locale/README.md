Description
===========

Sets default system locale

You can see which languages are available by 
$ locale -a 

On debian based systems you can set the locale by running
 update-locale LANG={lang}
e.g.
 update-locale LANG=en_AU.utf8

It updates the file /etc/default/locale

On rhel based systems you can set default locale updating /etc/sysconfig/i18n
There doesn't seem to be a command line tool to update this file?!?

Requirements
============

Tested on Ubuntu, CentOS

Attributes
==========

* `node[:locale][:lang]` -- defaults to "en_US.utf8"

Usage
=====

Include the default recipe in your run list.
