deployment_type = node['bonusbits_base']['deployment_type']
deployment_type_docker = deployment_type == 'docker'

case node['os']
when 'linux'
  case node['platform_family']
  when 'redhat'
    # Configure SELinux
    selinux_state 'Disabling SELinux' do
      action node['bonusbits_base']['linux']['selinux']['action'].to_sym
      not_if { deployment_type_docker }
    end
  else
    return
  end
when 'windows'
  return
else
  return
end
