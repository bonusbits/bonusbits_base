# Selinux
default['bonusbits_base']['security']['selinux']['configure'] = true
default['bonusbits_base']['security']['selinux']['action'] = 'disabled'

# Debug
message_list = [
  '',
  '** Security **',
  "Configure Selinux           (#{node['bonusbits_base']['security']['selinux']['configure']})",
  "Configure Selinux Action    (#{node['bonusbits_base']['security']['selinux']['action']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
