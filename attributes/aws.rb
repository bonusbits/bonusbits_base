default['bonusbits_base']['aws']['install_tools'] = false

default['bonusbits_base']['aws']['region'] =
  if node['c1_jenkins2x']['deployment_type'] == 'ec2'
    node['ec2']['placement_availability_zone'].slice(0..-2)
  else
    'us-west-2'
  end

# Debug
message_list = [
  '',
  '** AWS **',
  "Region                      (#{node['bonusbits_base']['aws']['region']})",
  "Inside AWS                  (#{node['bonusbits_base']['deployment_type'] == 'ec2'})",
  "Install Tools               (#{node['bonusbits_base']['aws']['install_tools']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
