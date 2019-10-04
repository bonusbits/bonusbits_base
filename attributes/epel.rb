default['bonusbits_base']['epel'].tap do |epel|
  # EPEL Repos
  epel['configure'] = false
  epel['install_packages'] = false

  epel['packages'] = %w[
    htop
  ]
end

# Debug
message_list = [
  '',
  '** Epel **',
  "Configure                   (#{node['bonusbits_base']['epel']['configure']})",
  "Install EPEL Packages       (#{node['bonusbits_base']['epel']['install_packages']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
