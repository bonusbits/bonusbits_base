default['bonusbits_base']['sudoers']['configure'] = true

# Debug
message_list = [
  '',
  '** Sudoers **',
  "INFO: Configure             (#{node['bonusbits_base']['sudoers']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
