default['bonusbits_base']['java'].tap do |java|
  java['install'] = false
  java['remove_older'] = true

  # Java Package Name
  java['package'] = 'java-1.8.0-openjdk' # Example

  # Java Package Version (Lock Version Option)
  java['specify_version'] = false # Otherwise Latest will be installed
  java['version'] =
    if amazon_linux1?
      '1.8.0.151-1.b12.35.amzn1'
    elsif amazon_linux2?
      '1.8.0.222.b10-0.amzn2.0.1'
    end # Examples
  # RHEL7 '1.8.0.141-1.b16.el7_3'
end

# Debug
message_list = [
  '',
  '** Java **',
  "Install                     (#{node['bonusbits_base']['java']['install']})",
  "Remove Older                (#{node['bonusbits_base']['java']['remove_older']})",
  "Package                     (#{node['bonusbits_base']['java']['package']})",
  "Version                     (#{node['bonusbits_base']['java']['version']})",
  "Specific Version            (#{node['bonusbits_base']['java']['specify_version']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
