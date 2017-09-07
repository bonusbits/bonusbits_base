default['bonusbits_base']['java']['install'] = false
default['bonusbits_base']['java']['remove_older'] = true
default['bonusbits_base']['java']['specify_version'] = false # Otherwise Latest will be installed

default['bonusbits_base']['java']['package'] = 'java-1.8.0-openjdk'
default['bonusbits_base']['java']['version'] = '1.8.0.141-1.b16.el7_3'

# Debug
message_list = [
  '',
  '** Java **',
  "Install                     (#{node['bonusbits_base']['java']['install']})",
  "Remove Older                (#{node['bonusbits_base']['java']['remove_older']})",
  "Package                     (#{node['bonusbits_base']['java']['package']})",
  "Version                     (#{node['bonusbits_base']['java']['version']})",
  "Specific Version            (#{node['bonusbits_base']['java']['specify_version']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
