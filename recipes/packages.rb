platform = node['platform']

install_epel_list =
  node['bonusbits_base']['packages']['linux']['epel']['install_packages']
setup_epel = node['bonusbits_base']['packages']['linux']['epel']['configure']

# Package Lists
amazon_packages = node['bonusbits_base']['packages']['linux']['amazon_packages']
debian_packages = node['bonusbits_base']['packages']['linux']['debian_packages']
epel_packages = node['bonusbits_base']['packages']['linux']['epel_packages']
redhat_packages = node['bonusbits_base']['packages']['linux']['redhat_packages']
suse_packages = node['bonusbits_base']['packages']['linux']['suse_packages']

case platform
# Install Software Packages
when 'debian', 'ubuntu'
  execute 'apt-get update && apt-get -y upgrade'
  include_recipe 'apt'
  package debian_packages
when 'redhat', 'centos'
  execute 'yum update -y'
  package redhat_packages
  include_recipe 'yum-epel' if setup_epel
  package epel_packages if install_epel_list
when 'amazon'
  execute 'yum update -y'
  package amazon_packages
  # EPEL Repo setup by Default on Amazon Linux,
  # but is external source so internet access required to install the package list
  package epel_packages
when 'suse', 'opensuse'
  package suse_packages
else
  return
end
