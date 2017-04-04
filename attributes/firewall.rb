default['bonusbits_base']['firewall']['configure'] = false

# Firewall Community Cookbook
default['firewall']['ipv6_enabled'] = false
default['firewall']['redhat7_iptables'] = true
default['firewall']['ubuntu_iptables'] = true

# Iptables
default['bonusbits_base']['firewall']['iptables']['type'] = 'iptables'
default['bonusbits_base']['firewall']['iptables']['rules'] = {
  loopback: '-A INPUT -i lo -j ACCEPT',
  established: '-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT',
  icmp: '-A INPUT -p icmp -j ACCEPT',
  ssh: '-A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT',
  rsync: '-A INPUT -p tcp --dport 873 -m state --state NEW,ESTABLISHED
  -j ACCEPT'
}

# Debug
message_list = [
  '',
  '** Firewall **',
  "INFO: Configure             (#{node['bonusbits_base']['firewall']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
