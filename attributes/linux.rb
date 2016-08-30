# Package Repos
default['bonusbits_base']['linux']['repos']['setup_epel'] = false

# Packages
default['bonusbits_base']['linux']['packages']['install_base_list'] = true
default['bonusbits_base']['linux']['packages']['install_epel_list'] = false
default['bonusbits_base']['linux']['packages']['action'] = 'install'
default['bonusbits_base']['linux']['packages']['rh_package_list'] =
  %w(vim-enhanced mlocate wget)
default['bonusbits_base']['linux']['packages']['rh_epel_package_list'] =
  %w(htop)
default['bonusbits_base']['linux']['packages']['deb_package_list'] =
  %w(vim mlocate wget)

# Selinux
default['bonusbits_base']['linux']['selinux']['configure'] = true
default['bonusbits_base']['linux']['selinux']['action'] = 'disabled'

# Firewall
default['bonusbits_base']['linux']['firewall']['type'] = 'iptables'
default['bonusbits_base']['linux']['firewall']['rules'] = {
  loopback: '-A INPUT -i lo -j ACCEPT',
  established: '-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT',
  icmp: '-A INPUT -p icmp -j ACCEPT',
  ssh: '-A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT',
  rsync: '-A INPUT -p tcp --dport 873 -m state --state NEW,ESTABLISHED
-j ACCEPT'
}
default['firewall']['redhat7_iptables'] = true
default['firewall']['ubuntu_iptables'] = true

# TODO: Remove when test-kitchen bug fixed
# (Used for Setup/Verify Test Gem Download Phase Such as Busser download)
# Proxy - Defaults for Charles Proxy setup
default['bonusbits_base']['linux']['network_proxy']['variables'] = <<-EOH
ftp_proxy=http://10.0.2.2:8888
http_proxy=http://10.0.2.2:8888
https_proxy=http://10.0.2.2:8888
no_proxy=localhost,127.0.0.1,10.0.2.,33.33.33.,.localdomain.com
FTP_PROXY=http://10.0.2.2:8888
HTTPS_PROXY=http://10.0.2.2:8888
HTTP_PROXY=http://10.0.2.2:8888
NO_PROXY=localhost,127.0.0.1,10.0.2.,33.33.33.,.localdomain.com
EOH
