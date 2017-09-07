# To save money in-case an EC2 Test Kitchen is forgotten and left on the default to terminate at night.
deployment_method = node['bonusbits_base']['deployment_method']
deployment_method_kitchen = deployment_method == 'kitchen'
ec2_deployment = node['c1_jenkins2x']['deployment_type'] == 'ec2'
default['bonusbits_base']['kitchen_shutdown']['configure'] =
  if deployment_method_kitchen && ec2_deployment
    true
  else
    false
  end

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
