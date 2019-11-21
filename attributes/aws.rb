default['bonusbits_base']['aws'].tap do |aws|
  aws['install_tools'] = false
  # AWS Environment
  aws['account_id'] = ec2? ? node['ec2']['account_id'] : '00000000'

  # Region
  aws['region'] = ec2? ? node['ec2']['region'] : 'us-west-2'
  aws['simple_region'] = ec2? ? node['ec2']['region'].slice(3..-1).slice(0..-3) : 'west'

  # Instance
  aws['instance_id'] = ec2? ? node['ec2']['instance_id'] : '000000000000'

  # Network
  aws['ec2']['security_group_ids'] = ec2? ? node['ec2']['network_interfaces_macs'][node['ec2']['mac']]['security_group_ids'].split(/\n/) : 'sg-00000000'
end

# Debug
message_list = [
  '',
  '** AWS **',
  "Inside AWS                  (#{aws?})",
  "Account ID                  (#{node['bonusbits_base']['aws']['account_id']})",
  "Instance ID                 (#{node['bonusbits_base']['aws']['instance_id']})",
  "Region                      (#{node['bonusbits_base']['aws']['region']})",
  "Simple Region               (#{node['bonusbits_base']['aws']['simple_region']})",
  "Security Groups IDs         (#{node['bonusbits_base']['aws']['security_group_ids']})",
  "Install Tools               (#{node['bonusbits_base']['aws']['install_tools']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
