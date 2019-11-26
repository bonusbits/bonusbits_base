# To create /etc/sysconfig/network for init scripts such as Nginx
default['bonusbits_base']['docker']['deploy_sysconfig_network'] =
  node['bonusbits_base']['deployment_type'] == 'docker'

# Debug
message_list = [
  '',
  '** Docker **',
  "Deploy Sysconfig Network    (#{node['bonusbits_base']['docker']['deploy_sysconfig_network']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
