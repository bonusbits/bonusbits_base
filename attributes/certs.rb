default['bonusbits_base']['certs'].tap do |certs|
  certs['configure'] = false
  certs['data_bag'] = 'bonusbits_base'
  certs['data_bag_item'] = 'internal_ca'
end

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
