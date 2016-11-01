platform = node['platform']
install_base_list =
  node['bonusbits_base']['linux']['packages']['install_base_list']
install_epel_list =
  node['bonusbits_base']['linux']['packages']['install_epel_list']
package_action = node['bonusbits_base']['linux']['packages']['action'].to_sym
deb_package_list =
  node['bonusbits_base']['linux']['packages']['deb_package_list']
rh_package_list =
  node['bonusbits_base']['linux']['packages']['rh_package_list']
rh_epel_package_list =
  node['bonusbits_base']['linux']['packages']['rh_epel_package_list']
suse_package_list =
  node['bonusbits_base']['linux']['packages']['suse_package_list']

file_contents = ::File.read('/proc/1/cgroup')
BonusBits::Output.report "REPORT: cgroup file content (#{file_contents})"

# Install Software Packages
install_software = node['bonusbits_base']['software']['install']
BonusBits::Output.report "Install Software?     (#{install_software})"
if install_software
  case platform
    when 'debian', 'ubuntu'
      include_recipe 'apt'
      package deb_package_list do
        action package_action
        only_if { install_base_list }
      end
      node.default['bonusbits_base']['linux']['selinux']['configure'] = false
      node.default['bonusbits_base']['firewall']['configure'] = false
    when 'redhat', 'centos', 'amazon'
      package rh_package_list do
        action package_action
        only_if { install_base_list }
      end
      setup_epel = node['bonusbits_base']['linux']['repos']['setup_epel']
      BonusBits::Output.report "Setup EPEL?           (#{setup_epel})"
      if setup_epel
        include_recipe 'yum-epel'
        package rh_epel_package_list do
          action package_action
          only_if { install_epel_list }
        end
      end
    when 'suse', 'opensuse'
      package suse_package_list do
        action package_action
        only_if { install_base_list }
      end
      node.default['bonusbits_base']['linux']['selinux']['configure'] = false
      node.default['bonusbits_base']['firewall']['configure'] = false
    else
      BonusBits::Output.break "OS Platform Unknown   (#{platform})"
  end
end

# Deploy Node Info Script
deploy_nodeinfo = node['bonusbits_base']['nodeinfo_script']['deploy']
BonusBits::Output.report "Deploy nodeinfo?     (#{deploy_nodeinfo})"
template '/usr/bin/nodeinfo' do
  source 'nodeinfo.sh.erb'
  owner 'root'
  group 'root'
  mode 00755
  only_if { deploy_nodeinfo }
end

# Configure SELinux
configure_selinux = node['bonusbits_base']['linux']['selinux']['configure']
BonusBits::Output.report "Configure Selinux?    (#{configure_selinux})"
selinux_state 'Disabling SELinux' do
  action node['bonusbits_base']['linux']['selinux']['action'].to_sym
  only_if { configure_selinux }
end

# Configure Firewall
configure_firewall = node['bonusbits_base']['firewall']['configure']
BonusBits::Output.report "Configure Firewall?   (#{configure_firewall})"
if configure_firewall
  firewall 'default' do
    action :install
  end

  firewall_rules = node['bonusbits_base']['linux']['firewall']['rules']
  unless firewall_rules.empty?
    firewall_rules.each do |rule, raw_parameters|
      firewall_rule rule do
        raw raw_parameters
      end
    end
  end
end

# Configure Network Proxy for Vagrant Setups so Test Gems can be Downloaded
configure_proxy = node['bonusbits_base']['network_proxy']['configure']
BonusBits::Output.report "Setup Network Proxy?  (#{configure_proxy})"
if configure_proxy
  BonusBits::Output.action 'Adding Network Proxy to Instance Environment File'
  # TODO: Remove when bug fixed in test-kitchen
  # Add Proxy to Vagrant Shell Environment
  template '/etc/environment' do
    source 'linux_network_proxy.erb'
    owner 'root'
    group 'root'
    mode 00644
    notifies :run, 'execute[source_environment_file]', :immediately
  end

  execute 'source_environment_file' do
    command '. /etc/environment'
    action :nothing
  end
end

# Set Internal GEM Source
configure_gem_source = node['bonusbits_base']['gem_source']['use_internal']
BonusBits::Output.report "Setup RubyGem Source? (#{configure_gem_source})"
if configure_gem_source
  gemrc_path = '/root/.gemrc'
  BonusBits::Output.report("Writing Gemrc Config  (#{gemrc_path}/.gemrc)")
  template gemrc_path do
    source 'gemrc.erb'
    owner 'root'
    group 'root'
    mode 00644
  end
end
