# Package Lists
amazon_packages = node['bonusbits_base']['packages']['linux']['amazon_packages']
debian_packages = node['bonusbits_base']['packages']['linux']['debian_packages']
redhat_packages = node['bonusbits_base']['packages']['linux']['redhat_packages']
suse_packages = node['bonusbits_base']['packages']['linux']['suse_packages']

case node['platform']
# Install Software Packages
when 'debian', 'ubuntu'
  execute 'apt-get update && apt-get -y upgrade --exclude=kernel*'
  include_recipe 'apt'
  package debian_packages
when 'redhat', 'centos'
  execute 'yum update -y --exclude=kernel*'
  package redhat_packages
when 'amazon'
  execute 'yum update -y --exclude=kernel*'
  package amazon_packages
when 'suse', 'opensuse'
  package suse_packages
else
  return
end
