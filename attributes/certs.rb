default['bonusbits_base']['certs']['configure'] = false
default['bonusbits_base']['certs']['data_bag'] = 'bonusbits_base'
default['bonusbits_base']['certs']['data_bag_item'] = 'internal_ca'

if node['bonusbits_base']['certs']['configure']
  message_list = [
    '',
    '** Certs **',
    "INFO: Configure             (#{node['bonusbits_base']['certs']['configure']})",
    "INFO: Data Bag              (#{node['bonusbits_base']['certs']['data_bag']})",
    "INFO: Data Bag Item         (#{node['bonusbits_base']['certs']['data_bag_item']})"
  ]
  message_list.each do |message|
    Chef::Log.warn(message)
  end
end
