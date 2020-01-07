default['bonusbits_base']['security']['selinux'].tap do |selinux|
  # Selinux
  deployment_type = node['bonusbits_base']['deployment_type']
  deployment_type_docker = deployment_type == 'docker'
  selinux['configure'] = deployment_type_docker ? false : true
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
