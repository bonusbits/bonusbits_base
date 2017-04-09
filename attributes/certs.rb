default['bonusbits_base']['certs']['configure'] = false
default['bonusbits_base']['certs']['data_bag'] = 'bonusbits_base'
default['bonusbits_base']['certs']['data_bag_item'] = 'internal_ca'

message_list = [
  '',
  '** Certs **',
  "Configure                   (#{node['bonusbits_base']['certs']['configure']})",
  "Data Bag                    (#{node['bonusbits_base']['certs']['data_bag']})",
  "Data Bag Item               (#{node['bonusbits_base']['certs']['data_bag_item']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
