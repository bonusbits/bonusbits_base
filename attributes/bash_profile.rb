default['bonusbits_base']['bash_profile']['configure'] = true

# Debug
message_list = [
  '',
  '** BASH Profile **',
  "Configure                   (#{node['bonusbits_base']['bash_profile']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
