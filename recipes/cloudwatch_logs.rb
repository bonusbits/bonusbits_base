case node['os']
when 'linux'
  directory '/etc/awslogs' do
    owner 'root'
    group 'root'
    mode '0755'
  end

  case node['platform']
  when 'amazon'
    # Install CloudWatch Logs Agent
    package 'awslogs'
  else
    return
  end

  # Deploy AWS CLI Config
  template '/etc/awslogs/awscli.conf' do
    source 'cloudwatch_logs/awscli.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end

  # Deploy AWS CloudWatch Logs Config
  template '/etc/awslogs/awslogs.conf' do
    source 'cloudwatch_logs/awslogs.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[awslogs]', :delayed
    only_if { node['bonusbits_base']['aws']['inside'] } # Ohai EC2 Plugin Used
    # Wrapper Cookbook Should Lay down this file with customizations
    only_if { node['bonusbits_base']['cloudwatch_logs']['deploy_logs_conf'] }
  end

  # Define Service for Notifications
  service 'awslogs' do
    service_name 'awslogs'
    action [:enable, :start]
    only_if { node['bonusbits_base']['aws']['inside'] }
  end
when 'windows'
  return
else
  return
end
