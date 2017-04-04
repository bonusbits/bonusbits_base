# Selinux
default['bonusbits_base']['security']['selinux']['configure'] = true
default['bonusbits_base']['security']['selinux']['action'] = 'disabled'

# Debug
message_list = [
  '',
  '** Security **',
  "INFO: Configure Selinux     (#{node['bonusbits_base']['security']['selinux']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
