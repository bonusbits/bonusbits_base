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

  node_info['content'] =
    [
      '-- CHEF --',
      "Cert Data Bag               (#{node['bonusbits_base']['certs']['data_bag']})",
      "Cert Data Bag Item          (#{node['bonusbits_base']['certs']['data_bag_item']})",
      "Environment                 (#{node.environment})",
      "Node Name                   (#{node.name})",
      "Recipes                     (#{node['recipes']})",
      "Roles                       (#{node['roles']})",
      '',
      '-- DEPLOYMENT --',
      "Environment:                (#{node.run_state['detected_environment']})",
      "Location:                   (#{node['bonusbits_base']['deployment_location']})",
      "Method :                    (#{node['bonusbits_base']['deployment_method']})",
      "Type:                       (#{node['bonusbits_base']['deployment_type']})",
      "Time:                       (#{Time.now})",
      '',
      '-- HARDWARE --',
      "CPU Count:                  (#{node['cpu']['total']})",
      "Memory:                     (#{memory_in_megabytes}MB)",
      '',
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
      '-- PROXY --',
      "Host                        (#{node['bonusbits_base']['proxy']['host']})",
      "Port                        (#{node['bonusbits_base']['proxy']['port']})",
      "URL                         (#{node['bonusbits_base']['proxy']['url']})",
      "No Proxy                    (#{node['bonusbits_base']['proxy']['no_proxy']})"
    ]

  if ec2?
    node_info['content'].concat [
      '',
      '-- AWS --',
      "Instance ID:                (#{node['ec2']['instance_id']})",
      "Region:                     (#{node['ec2']['placement_availability_zone'].slice(0..-2)})",
      "Availability Zone:          (#{node['ec2']['placement_availability_zone']})",
      "AMI ID:                     (#{node['ec2']['ami_id']})",
      '',
      '-- EC2 --',
      "AMI ID                      (#{node['ec2']['ami_id']})",
      "AMI Name                    (#{ami_name})",
      "AMI Release                 (#{ami_release})",
      "AMI Version                 (#{ami_version})",
      "CPU Count                   (#{node['cpu']['total']})",
      "Instance ID                 (#{node['ec2']['instance_id']})",
      "Instance Type               (#{node['ec2']['instance_type']})",
      "Memory                      (#{memory_in_megabytes}MB)"
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
