# Deploy AWS Profile Script & Tools
include_recipe 'bonusbits_base::aws' if node['bonusbits_base']['deployment_type'] == 'ec2'

# Container Discovery
case node['platform']
when 'amazon'
  # Install & Configure Yum Cron (Only works on Amazon Linux So Far)
  include_recipe 'bonusbits_base::yum_cron' if node['bonusbits_base']['yum_cron']['configure']
else
  return
end

# Setup CloudWatch Logs
include_recipe 'bonusbits_base::cloudwatch_logs' if node['bonusbits_base']['cloudwatch_logs']['configure']

# Configure Proxy
include_recipe 'bonusbits_base::proxy' if node['bonusbits_base']['proxy']['configure']

# Configure Certs
include_recipe 'bonusbits_base::certs' if node['bonusbits_base']['certs']['configure']

# Configure Gem Source
include_recipe 'bonusbits_base::gem_source' if node['bonusbits_base']['gem_source']['configure']

# Configure Security
include_recipe 'bonusbits_base::security' if node['bonusbits_base']['security']['configure']

# Install Packages
include_recipe 'bonusbits_base::packages' if node['bonusbits_base']['packages']['install']

# Configure Sudoers on EC2 Instance
include_recipe 'bonusbits_base::sudoers' if node['bonusbits_base']['sudoers']['configure']

# Epel
include_recipe 'bonusbits_base::epel' if node['bonusbits_base']['epel']['configure']

# Configure Node Info
include_recipe 'bonusbits_base::node_info' if node['bonusbits_base']['node_info']['configure']

# Configure Kitchen Shutdown
include_recipe 'bonusbits_base::kitchen_shutdown' if node['bonusbits_base']['kitchen_shutdown']['configure']

# Configure BonusBits Bash Profile
include_recipe 'bonusbits_base::bash_profile' if node['bonusbits_base']['bash_profile']['configure']

# Configure BonusBits Bash Profile
include_recipe 'bonusbits_base::docker' if node['bonusbits_base']['docker']['deploy_sysconfig_network']

# Setup Backups
include_recipe 'bonusbits_base::cloudwatch' if node['bonusbits_base']['cloudwatch']['configure']

# Setup Backups
include_recipe 'bonusbits_base::backups' if node['bonusbits_base']['backups']['configure']

# Run InSpec Tests
include_recipe 'audit' if node['bonusbits_base']['audit']['configure']
