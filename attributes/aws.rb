default['bonusbits_base']['aws']['inside'] = false
default['bonusbits_base']['aws']['install_tools'] = true
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
  "INFO: Inside                (#{node['bonusbits_base']['aws']['inside']})",
  "INFO: Region                (#{node['bonusbits_base']['aws']['region']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
