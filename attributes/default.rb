# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node.environment
    /dev|qa|stg|prd/.match(node.environment).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

# Determine Deployment Type
default['bonusbits_base']['deployment_type'] =
  if node['virtualization']['system'] == 'docker'
    # if node['virtualization']['systems']['docker'] == 'guest'
    'docker'
  elsif node['virtualization']['system'] == 'lxc'
    'lxc'
  elsif node['virtualization']['system'] == 'lxd'
    'lxd'
  elsif node['virtualization']['system'] == 'kvm'
    'kvm'
  elsif node['virtualization']['system'] == 'vbox'
    'vbox'
  elsif BonusBits::Discovery.ec2?(node['fqdn'], node['platform_family'])
    'ec2'
  else
    'other'
  end

# Determine Deployment Location
default['bonusbits_base']['deployment_location'] =
  if ENV['CIRCLECI'] == 'true'
    'circleci'
  elsif BonusBits::Discovery.aws?(node['fqdn'], node['platform_family'])
    'aws'
  else
    'local'
  end

# Determine Deployment Method
## Mostly for Conditioning Audit Cookbook (Kitchen Handles the Audit when Used)
## TODO: Added vbox discovery?
deployment_location = node['bonusbits_base']['deployment_location']
deployment_type = node['bonusbits_base']['deployment_type']
deployment_location_local = deployment_location == 'local'
deployment_type_docker = deployment_type == 'docker'

default['bonusbits_base']['deployment_method'] =
  if ::File.directory?('/tmp/kitchen')
    'kitchen'
  elsif ::File.exist?('/var/lib/cloud/instance/scripts/part-001')
    'cloudformation'
  elsif deployment_type_docker && deployment_location_local
    'dockerfile'
  elsif deployment_type_docker
    'dockerimage'
  else
    'unknown'
  end

default['bonusbits_base']['local_file_cache'] = Chef::Config[:file_cache_path]

# Debug
message_list = [
  '',
  '** Default **',
  "Detected Environment        (#{run_state['detected_environment']})",
  "Deployment Type             (#{node['bonusbits_base']['deployment_type']})",
  "Deployment Location         (#{node['bonusbits_base']['deployment_location']})",
  "Deployment Method           (#{node['bonusbits_base']['deployment_method']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
