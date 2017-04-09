# Package Lists
amazon_packages = node['bonusbits_base']['packages']['linux']['amazon_packages']
debian_packages = node['bonusbits_base']['packages']['linux']['debian_packages']
redhat_packages = node['bonusbits_base']['packages']['linux']['redhat_packages']
suse_packages = node['bonusbits_base']['packages']['linux']['suse_packages']

if node['bonusbits_base']['packages']['update']
  # Update System Packages
  case node['platform']
  # Install Software Packages
  when 'debian', 'ubuntu'
    execute 'apt-get update && apt-get -y upgrade --exclude=kernel*'
  when 'redhat', 'centos'
    execute 'yum update -y --exclude=kernel*'
  when 'amazon'
    execute 'yum update -y --exclude=kernel*'
  else
    return
  end
end

# Install Software Packages
case node['platform']
when 'debian', 'ubuntu'
  include_recipe 'apt'
  package debian_packages
when 'redhat', 'centos'
  package redhat_packages
when 'amazon'
  package amazon_packages
when 'suse', 'opensuse'
  package suse_packages
else
  return
end
