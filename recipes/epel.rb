install_packages = node['bonusbits_base']['epel']['install_packages']
epel_packages = node['bonusbits_base']['epel']['packages']

case node['platform']
when 'redhat', 'centos'
  include_recipe 'yum-epel'
  package epel_packages if install_packages
when 'amazon'
  node.default['yum']['epel']['enabled'] = true
  include_recipe 'yum-epel'
  # yum_repository 'epel'
  # EPEL Repo setup by Default on Amazon Linux,
  # but is external source so internet access required to install the package list
  package epel_packages if install_packages
else
  return
end
