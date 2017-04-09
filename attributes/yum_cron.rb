default['bonusbits_base']['yum_cron']['configure'] = true

# Debug
message_list = [
  '',
  '** Yum Cron **',
  "Configure                   (#{node['bonusbits_base']['yum_cron']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
