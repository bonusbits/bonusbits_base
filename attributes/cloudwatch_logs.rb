default['bonusbits_base']['cloudwatch_logs']['configure'] = true
default['bonusbits_base']['cloudwatch_logs']['deploy_logs_conf'] = true
default['bonusbits_base']['cloudwatch_logs']['logs_group_name'] = 'kitchen-bonusbits-base'

# Debug
message_list = [
  '',
  '** CloudWatch Logs **',
  "Configure                   (#{node['bonusbits_base']['cloudwatch_logs']['configure']})",
  "Log Group Name              (#{node['bonusbits_base']['cloudwatch_logs']['logs_group_name']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
