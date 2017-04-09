default['bonusbits_base']['gem_source']['configure'] = false
default['bonusbits_base']['gem_source']['source_url'] =
  'https://artifactory.localdomain.com/artifactory/api/rubygems/'

# Debug
message_list = [
  '',
  '** Gem Source **',
  "Configure                   (#{node['bonusbits_base']['gem_source']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
