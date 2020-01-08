# WIP

default['bonusbits_base']['audit'].tap do |audit|
  audit['configure'] = false

  # Audit only if deployed from dockerfile
  # deployment_dockerfile =
  #     node['bonusbits_base']['deployment_method'] == 'dockerfile'
  #
  # audit['configure'] = deployment_dockerfile

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
end

# Debug
message_list = [
  '',
  '** Audit **',
  "Run InSpec from Cookbook    (#{node['bonusbits_base']['audit']['configure']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
