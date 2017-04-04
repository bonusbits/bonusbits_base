default['bonusbits_base']['gem_source']['configure'] = false
default['bonusbits_base']['gem_source']['internal_url'] =
  'https://nexus.localdomain.com/mother/content/repositories/rubygems.org/'

# Debug
message_list = [
  '',
  '** Gem Source **',
  "INFO: Configure             (#{node['bonusbits_base']['gem_source']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
