# Community Cookbooks
default['firewall']['redhat7_iptables'] = true
default['firewall']['ubuntu_iptables'] = true

# Append Attribute Prefix
default['bonusbits_base']['linux'].tap do |linux|
  # Package Repos
  linux['repos']['setup_epel'] = false

  # Packages
  linux['packages']['install_base_list'] = true
  linux['packages']['install_epel_list'] = false
  linux['packages']['action'] = 'install'
  linux['packages']['rh_package_list'] =
    %w(vim-enhanced mlocate wget)
  linux['packages']['rh_epel_package_list'] =
    %w(htop)
  linux['packages']['deb_package_list'] =
    %w(vim mlocate wget)

  # Selinux
  linux['selinux']['configure'] = true
  linux['selinux']['action'] = 'disabled'

  # Firewall
  linux['firewall']['type'] = 'iptables'
  linux['firewall']['rules'] = {
    loopback: '-A INPUT -i lo -j ACCEPT',
    established: '-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT',
    icmp: '-A INPUT -p icmp -j ACCEPT',
    ssh: '-A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT',
    rsync: '-A INPUT -p tcp --dport 873 -m state --state NEW,ESTABLISHED
  -j ACCEPT'
  }

  # TODO: Remove when test-kitchen bug fixed (I think fixed now, need to deprecate)
  # (Used for Setup/Verify Test Gem Download Phase Such as Busser download)
  # Proxy - Defaults for Charles Proxy setup
  linux['network_proxy']['variables'] = <<-EOH
  ftp_proxy=http://10.0.2.2:8888
  http_proxy=http://10.0.2.2:8888
  https_proxy=http://10.0.2.2:8888
  no_proxy=localhost,127.0.0.1,10.0.2.,33.33.33.,.localdomain.com
  FTP_PROXY=http://10.0.2.2:8888
  HTTPS_PROXY=http://10.0.2.2:8888
  HTTP_PROXY=http://10.0.2.2:8888
  NO_PROXY=localhost,127.0.0.1,10.0.2.,33.33.33.,.localdomain.com
  EOH
end
