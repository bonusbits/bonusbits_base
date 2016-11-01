# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node['chef_environment']
    /dev|qa|stg|prd/.match(node['chef_environment']).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

# Community Cookbooks
default['firewall']['ipv6_enabled'] = false

# Convert Memory Total to Megabytes
memory_in_megabytes =
  case node['os']
    when /.*bsd/
      node['memory']['total'].to_i / 1024 / 1024
    when 'linux'
      node['memory']['total'][/\d*/].to_i / 1024
    when 'darwin'
      node['memory']['total'][/\d*/].to_i
    when 'windows', 'solaris', 'hpux', 'aix'
      node['memory']['total'][/\d*/].to_i / 1024
  end

default['bonusbits_base'].tap do |root|
  # Proxy
  root['network_proxy']['configure'] = false

  # Gem Source
  root['gem_source']['use_internal'] = false
  root['gem_source']['internal_url'] =
    'https://nexus.localdomain.com/mother/content/repositories/rubygems.org/'

  # Firewall
  root['firewall']['configure'] = false

  # Software Installs
  root['software']['install'] = true

  # NodeInfo Script
  root['nodeinfo_script']['deploy'] = true

  root['nodeinfo_script']['content'] = [
    "IP Address:           (#{node['ipaddress']})",
    "Hostname:             (#{node['hostname']})",
    "FQDN:                 (#{node['fqdn']})",
    "Platform:             (#{node['platform']})",
    "Platform Version:     (#{node['platform_version']})",
    "Platform Family:      (#{node['platform_family']})",
    "CPU Count:            (#{node['cpu']['total']})",
    "Memory:               (#{memory_in_megabytes}MB)",
    "Detected Environment: (#{node.run_state['detected_environment']})",
    "Chef Environment:     (#{node.environment})",
    "Chef Roles:           (#{node['roles']})",
    "Chef Recipes:         (#{node['recipes']})"
  ]
end
