default['bonusbits_base']['security']['selinux'].tap do |selinux|
  # Selinux
  selinux['configure'] = true
  selinux['action'] = 'disabled'
end

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
