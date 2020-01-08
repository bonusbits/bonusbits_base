default['bonusbits_base']['cloudwatch_logs'].tap do |cloudwatch_logs|
  cloudwatch_logs['configure'] = aws?
  cloudwatch_logs['logs_group_name'] = 'kitchen-bonusbits-base'
  cloudwatch_logs['additional_logs'] = nil
  # additional_logs = node['bonusbits_base']['cloudwatch_logs']['additional_logs'].nil? ? false : true
end

# Debug
message_list = [
  '',
  '** CloudWatch Logs **',
  "Configure                   (#{node['bonusbits_base']['cloudwatch_logs']['configure']})",
  "Log Group Name              (#{node['bonusbits_base']['cloudwatch_logs']['logs_group_name']})"
  # "Has Additional Logs         (#{additional_logs})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
