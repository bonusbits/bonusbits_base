# To create /etc/sysconfig/network for init scripts such as Nginx
default['bonusbits_base']['docker']['deploy_sysconfig_network'] =
  if node['bonusbits_base']['deployment_type'] == 'docker'
    true
  else
    false
  end

# Debug
message_list = [
  '',
  '** Docker **',
  "INFO: Deploy Sysconfig Network (#{node['bonusbits_base']['docker']['deploy_sysconfig_network']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
