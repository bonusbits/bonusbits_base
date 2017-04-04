# Container Discovery
case node['platform']
when 'amazon'
  # Install & Configure Yum Cron (Only works on Amazon Linux So Far)
  include_recipe 'bonusbits_base::yum_cron' if node['bonusbits_base']['yum_cron']['configure']
else
  return
end

# Run Container Discovery
bonusbits_library_discovery 'Container Discovery' do
  action :container
end

if node['bonusbits_base']['aws']['inside']
  # Setup CloudWatch Logs
  include_recipe 'bonusbits_base::cloudwatch_logs' if node['bonusbits_base']['cloudwatch_logs']['configure']

  # Configure Sudoers on EC2 Instance
  include_recipe 'bonusbits_base::sudoers' if node['bonusbits_base']['sudoers']['configure']

  # Install AWS Tools (Pip Required) TODO: Finish Recipe
  # include_recipe 'bonusbits_base::aws' if node['bonusbits_base']['aws']['install_tools']
end

# Configure Proxy
include_recipe 'bonusbits_base::proxy' if node['bonusbits_base']['proxy']['configure']

# Configure Certs
include_recipe 'bonusbits_base::certs' if node['bonusbits_base']['certs']['configure']

# Configure Gem Source
include_recipe 'bonusbits_base::gem_source' if node['bonusbits_base']['gem_source']['configure']

# Configure Security
include_recipe 'bonusbits_base::security' if node['bonusbits_base']['security']['configure']

# Install Packages
include_recipe 'bonusbits_base::packages' if node['bonusbits_base']['packages']['configure']

# Configure Firewall
include_recipe 'bonusbits_base::firewall' if node['bonusbits_base']['firewall']['configure']

# Configure Node Info
include_recipe 'bonusbits_base::node_info' if node['bonusbits_base']['node_info']['configure']
