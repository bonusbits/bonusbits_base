# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node.environment
    /dev|qa|stg|prd/.match(node.environment).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

# TODO: OHAI PLUGIN STOPPED WORKING! Maybe Newer version of Docker causing problem...
default['bonusbits_base'].tap do |root|
  # Determine Deployment Type
  root['deployment_type'] =
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
    elsif node['virtualization']['system'] == 'xen' && BonusBits::Discovery.ec2?(node['fqdn'], node['platform_family'])
      'ec2'
    elsif File.exist?('/.dockerenv') # Workaround for Ohai Virtualization Plugin Failing on Docker now
      'docker'
    else
      'other'
    end

  # Determine Deployment Location
  ## Circleci Logic Does not work if spawning Docker
  ## containers in CircleCi because nested VM. Override in Kitchen Config
  root['deployment_location'] =
    if ENV['CIRCLECI']
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

  root['deployment_method'] =
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

  # File Cache
  root['local_file_cache'] = Chef::Config[:file_cache_path]

  # Chef Install Path
  root['chef_path'] =
    if ::File.directory?('/opt/chef')
      '/opt/chef'
    elsif ::File.directory?('/opt/chefdk')
      '/opt/chefdk'
    else
      raise 'ERROR: Chef Install Path Not Found!'
    end
end

# Debug
message_list = [
  '',
  '** Default **',
  "Detected Environment        (#{run_state['detected_environment']})",
  "Deployment Type             (#{node['bonusbits_base']['deployment_type']})",
  "Deployment Location         (#{node['bonusbits_base']['deployment_location']})",
  "Deployment Method           (#{node['bonusbits_base']['deployment_method']})",
  "Local File Cache            (#{node['bonusbits_base']['local_file_cache']})",
  "Chef Install Path           (#{node['bonusbits_base']['chef_path']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
