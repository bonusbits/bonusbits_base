# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node.environment
    /dev|qa|stg|prd/.match(node.environment).to_s.downcase
  else
    # For when environment is default Chef-Zero/Chef-Solo just consider it Dev
    'dev'
  end

# Proxy
default['bonusbits_base']['network_proxy']['configure'] = false

# Gem Source
default['bonusbits_base']['gem_source']['use_internal'] = false
default['bonusbits_base']['gem_source']['internal_url'] =
  'https://nexus.localdomain.com/mother/content/repositories/rubygems.org/'

# Firewall
default['bonusbits_base']['firewall']['configure'] = true
default['firewall']['ipv6_enabled'] = false

# Software Installs
default['bonusbits_base']['software']['install'] = true

# NodeInfo Script
default['bonusbits_base']['nodeinfo_script']['deploy'] = true

## Convert Memory Total to Megabytes
memory_in_megabytes =
  case node['os']
  when /.*bsd/
    node.memory.total.to_i / 1024 / 1024
  when 'linux'
    node.memory.total[/\d*/].to_i / 1024
  when 'darwin'
    node.memory.total[/\d*/].to_i
  when 'windows', 'solaris', 'hpux', 'aix'
    node.memory.total[/\d*/].to_i / 1024
  end

default['bonusbits_base']['nodeinfo_script']['content'] = [
  "IP Address:           (#{node['ipaddress']})",
  "Hostname:             (#{node['hostname']})",
  "FQDN:                 (#{node['fqdn']})",
  "Platform:             (#{node['platform']})",
  "Platform Version:     (#{node['platform_version']})",
  "CPU Count:            (#{node['cpu']['total']})",
  "Memory:               (#{memory_in_megabytes}MB)",
  "Detected Environment: (#{node.run_state['detected_environment']})",
  "Chef Environment:     (#{node.environment})",
  "Chef Roles:           (#{node['roles']})",
  "Chef Recipes:         (#{node['recipes']})"
]
