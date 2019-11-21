default['bonusbits_base']['ec2_status'].tap do |ec2_status|
  ec2_status['check'] = ec2?
  ec2_status['indicator_file'] = '/etc/chef/instance_initialized.ind'
end

# Debug
[
  '',
  '** EC2 Status **',
  "Check                       (#{node['bonusbits_base']['ec2_status']['check']})",
  "Indicator File              (#{node['bonusbits_base']['ec2_status']['indicator_file']})"
].each do |message|
  Chef::Log.warn(message)
end
