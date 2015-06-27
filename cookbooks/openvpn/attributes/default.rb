default["openvpn"]["generate_cert"] = false

default["openvpn"]["local"] = node["ipaddress"]

default["openvpn"]["proto"]   = "tcp"
default["openvpn"]["port"]    = "443"
default["openvpn"]["subnet"]  = "10.77.2.0"

default["openvpn"]["type"]    = "server"
default["openvpn"]["netmask"] = "255.255.255.0"
default["openvpn"]["gateway"] = "vpn.#{node["domain"]}"
default["openvpn"]["log"]     = "/var/log/openvpn.log"
default["openvpn"]["key_dir"] = "/etc/openvpn/keys"
default["openvpn"]["signing_ca_key"]  = "#{node["openvpn"]["key_dir"]}/ca.key"
default["openvpn"]["signing_ca_cert"] = "#{node["openvpn"]["key_dir"]}/ca.crt"
default["openvpn"]["push"] = true
default["openvpn"]["routes"] = []
default["openvpn"]["script_security"] = 3
default["openvpn"]["user"] = "nobody"
case platform
when "redhat", "centos", "fedora"
  default["openvpn"]["group"] = "nobody"
else
  default["openvpn"]["group"] = "nogroup"
end

default["openvpn"]["status_refresh_interval"] = 1

# Used by helper library to generate certificates/keys
default["openvpn"]["key"]["ca_expire"] = 3650
default["openvpn"]["key"]["expire"]    = 3650
default["openvpn"]["key"]["size"]      = 1024
default["openvpn"]["key"]["country"]   = "SC"
default["openvpn"]["key"]["province"]  = "SC"
default["openvpn"]["key"]["city"]      = "Victoria"
default["openvpn"]["key"]["org"]       = "SmartVPN Ltd."
default["openvpn"]["key"]["email"]     = "admin@smartvpn.biz"

default["openvpn"]["gems_source"] = "https://"
default["openvpn"]["openvpn-http-hooks-version"] = "1.0.6"
