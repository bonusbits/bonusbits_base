case node['os']
when 'linux'
  case node['platform_family']
  when 'redhat'
    # Configure SELinux
    selinux_state 'Disabling SELinux' do
      action node['bonusbits_base']['linux']['selinux']['action'].to_sym
    end
  else
    return
  end
when 'windows'
  return
else
  return
end
