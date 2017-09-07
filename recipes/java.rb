# Install Java OpenJDK from Package Repositories
## (Before Uninstalling older so don't have to install deps)
if node['bonusbits_base']['java']['specify_version']
  package node['bonusbits_base']['java']['package'] do
    action :install
    version node['bonusbits_base']['java']['version']
  end
else
  package node['bonusbits_base']['java']['package']
end

if node['bonusbits_base']['java']['remove_older']
  # Remove Java 1.7.0
  package 'java-1.7.0-openjdk' do
    action :remove
    ignore_failure
  end
  # Remove Java 1.6.0
  package 'java-1.6.0-openjdk' do
    action :remove
    ignore_failure
  end
end
