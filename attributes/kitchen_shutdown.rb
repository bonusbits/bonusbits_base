default['bonusbits_base']['kitchen_shutdown']['configure'] = false
# Default 2AM UTC = 7PM PST/10PM EST
default['bonusbits_base']['kitchen_shutdown']['minute'] = '0'
default['bonusbits_base']['kitchen_shutdown']['hour'] = '2'

# Debug
message_list = [
  '',
  '** Kitchen Shutdown **',
  "INFO: Configure             (#{node['bonusbits_base']['kitchen_shutdown']['configure']})",
  "INFO: Min to Shutdown       (#{node['bonusbits_base']['kitchen_shutdown']['minute']})",
  "INFO: Hour to Shutdown      (#{node['bonusbits_base']['kitchen_shutdown']['hour']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
