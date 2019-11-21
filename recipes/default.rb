# Ensure Chef config directory exists
directory '/etc/chef'

# Configure Proxy
include_recipe 'bonusbits_base::proxy' if node['bonusbits_base']['proxy']['configure']

# Wait for EC2 Instance Status 'ok' (Custom Resource)
## This is to deal with running code before the Appliance AMI has had time to initialize.
## In a little more intelligent way than just sleeping ever single time Chef runs. -=Levon
## Requires aws-sdk (included in chefdk)
ec2_status 'check ec2 status' if node['bonusbits_base']['ec2_status']['check']

# Deploy AWS Profile Script & Tools
include_recipe 'bonusbits_base::aws' if aws?

# Setup CloudWatch Logs
include_recipe 'bonusbits_base::cloudwatch_logs' if node['bonusbits_base']['cloudwatch_logs']['configure']

# Configure Certs
include_recipe 'bonusbits_base::certs' if node['bonusbits_base']['certs']['configure']

# Configure Gem Source
include_recipe 'bonusbits_base::gem_source' if node['bonusbits_base']['gem_source']['configure']

# Configure Security
include_recipe 'bonusbits_base::security' if node['bonusbits_base']['security']['configure']

# Install Packages
include_recipe 'bonusbits_base::packages' if node['bonusbits_base']['packages']['install']

# Install Java
include_recipe 'bonusbits_base::java' if node['bonusbits_base']['java']['install']

# Configure Sudoers on EC2 Instance
include_recipe 'bonusbits_base::sudoers' if node['bonusbits_base']['sudoers']['configure']

# Configure Node Info
include_recipe 'bonusbits_base::node_info' if node['bonusbits_base']['node_info']['configure']

# Configure Kitchen Shutdown
include_recipe 'bonusbits_base::kitchen_shutdown' if node['bonusbits_base']['kitchen_shutdown']['configure']

# Configure BonusBits Bash Profile
include_recipe 'bonusbits_base::bash_profile' if node['bonusbits_base']['bash_profile']['configure']

# Configure BonusBits Bash Profile
include_recipe 'bonusbits_base::docker' if node['bonusbits_base']['docker']['deploy_sysconfig_network']

# Setup Cloudwatch
include_recipe 'bonusbits_base::cloudwatch' if node['bonusbits_base']['cloudwatch']['configure']

# Setup Backups
include_recipe 'bonusbits_base::backups' if node['bonusbits_base']['backups']['configure']

# Run InSpec Tests
include_recipe 'audit' if node['bonusbits_base']['audit']['configure']
