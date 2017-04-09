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

default['bonusbits_base']['node_info'].tap do |node_info|
  node_info['configure'] = true

  if node['bonusbits_base']['aws']['inside']
    node_info['content'] = [
      '-- NETWORK --',
      "IP Address:                 (#{node['ipaddress']})",
      "Hostname:                   (#{node['hostname']})",
      "FQDN:                       (#{node['fqdn']})",
      '',
      '-- AWS --',
      "Instance ID:                (#{node['ec2']['instance_id']})",
      "Region:                     (#{node['ec2']['placement_availability_zone'].slice(0..-2)})",
      "Availability Zone:          (#{node['ec2']['placement_availability_zone']})",
      "AMI ID:                     (#{node['ec2']['ami_id']})",
      '',
      '-- PLATFORM --',
      "OS:                         (#{node['os']})",
      "Platform:                   (#{node['platform']})",
      "Platform Version:           (#{node['platform_version']})",
      "Platform Family:            (#{node['platform_family']})",
      '',
      '-- HARDWARE --',
      "CPU Count:                  (#{node['cpu']['total']})",
      "Memory:                     (#{memory_in_megabytes}MB)",
      '',
      '-- CHEF --',
      "Detected Environment:       (#{node.run_state['detected_environment']})",
      "Chef Environment:           (#{node.environment})",
      "Chef Roles:                 (#{node['roles']})",
      "Chef Recipes:               (#{node['recipes']})"
    ]
  else
    node_info['content'] = [
      '-- NETWORK --',
      "IP Address:                 (#{node['ipaddress']})",
      "Hostname:                   (#{node['hostname']})",
      "FQDN:                       (#{node['fqdn']})",
      '',
      '-- PLATFORM --',
      "OS:                         (#{node['os']})",
      "Platform:                   (#{node['platform']})",
      "Platform Version:           (#{node['platform_version']})",
      "Platform Family:            (#{node['platform_family']})",
      '',
      '-- HARDWARE --',
      "CPU Count:                  (#{node['cpu']['total']})",
      "Memory:                     (#{memory_in_megabytes}MB)",
      '',
      '-- CHEF --',
      "Detected Environment:       (#{node.run_state['detected_environment']})",
      "Chef Environment:           (#{node.environment})",
      "Chef Roles:                 (#{node['roles']})",
      "Chef Recipes:               (#{node['recipes']})"
    ]
  end
end

# Debug
message_list = [
  '',
  '** Node Info **',
  "Configure                   (#{node['bonusbits_base']['node_info']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
node['bonusbits_base']['node_info']['content'].each do |message|
  Chef::Log.warn(message)
end
