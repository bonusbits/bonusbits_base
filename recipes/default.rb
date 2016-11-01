BonusBits::Output.report "Platform              (#{node['platform']})"
BonusBits::Output.report "Platform Version:     (#{node['platform_version']})"
BonusBits::Output.report "Platform Family       (#{node['platform_family']})"
BonusBits::Output.report "OS Type               (#{node['os']})"
BonusBits::Output.report "OS Version            (#{node['os_version']})"
BonusBits::Output.report "Chef Environment:     (#{node.environment})"
BonusBits::Output.report "Detected Environment: (#{node.run_state['detected_environment']})"

# Linux vs Windows
case node['os']
  when 'linux'
    include_recipe 'bonusbits_base::linux'
    bonusbits_library_discovery 'Docker Discovery' do
      action :container
    end
  when 'windows'
    include_recipe 'bonusbits_base::windows'
  else
    BonusBits::Output.report 'OS = Unknown'
end
