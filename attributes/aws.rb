default['bonusbits_base']['aws']['install_tools'] = false
default['bonusbits_base']['aws']['inside'] =
  if node['bonusbits_base']['deployment_location'] == 'aws'
    true
  else
    false
  end
default['bonusbits_base']['aws']['region'] =
  if node['bonusbits_base']['aws']['inside']
    node['ec2']['placement_availability_zone'].slice(0..-2)
  else
    'unknown'
  end

# Debug
message_list = [
  '',
  '** AWS **',
  "Region                      (#{node['bonusbits_base']['aws']['region']})",
  "Inside AWS                  (#{node['bonusbits_base']['aws']['inside']})",
  "Install Tools               (#{node['bonusbits_base']['aws']['install_tools']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
