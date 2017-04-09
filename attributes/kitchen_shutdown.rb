default['bonusbits_base']['kitchen_shutdown']['configure'] = false
# Default 7AM UTC = 11PM PST/2AM EST
default['bonusbits_base']['kitchen_shutdown']['minute'] = '0'
default['bonusbits_base']['kitchen_shutdown']['hour'] = '6'

# Debug
message_list = [
  '',
  '** Kitchen Shutdown **',
  "Configure                   (#{node['bonusbits_base']['kitchen_shutdown']['configure']})",
  "Min to Shutdown             (#{node['bonusbits_base']['kitchen_shutdown']['minute']})",
  "Hour to Shutdown            (#{node['bonusbits_base']['kitchen_shutdown']['hour']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
