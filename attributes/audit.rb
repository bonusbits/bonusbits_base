deployment_dockerfile =
  node['bonusbits_base']['deployment_method'] == 'dockerfile'

default['bonusbits_base']['audit']['configure'] = deployment_dockerfile

# Audit Cookbook Attributes
default['audit']['collector'] = 'chef-visibility'
default['audit']['profiles'] =  [
  {
    name: 'bootstrap',
    git: 'https://github.com/bonusbits/inspec_bootstrap.git'
  },
  {
    name: 'bonusbits_base',
    git: 'https://github.com/bonusbits/inspec_bonusbits_base.git'
  }
]

# Debug
message_list = [
  '',
  '** Audit **',
  "Run InSpec from Cookbook    (#{node['bonusbits_base']['audit']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
