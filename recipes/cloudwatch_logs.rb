ec2_deployment = ec2?

case node['os']
when 'linux'
  case node['platform']
  when 'amazon'
    # Install CloudWatch Logs Agent
    package 'awslogs'

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
      variables(
        state_file: '/var/lib/awslogs/agent-state'
      )
      notifies :restart, 'service[awslogs]', :delayed
      only_if { ec2_deployment } # Template calls ohai ec2
    end
  when 'centos', 'redhat' # ~FC024
    package %w[python python-setuptools]

    # Create Symlink to configs.
    ## So if used to looking for the configs where the RPM installs.
    ## Plus can DRY a little code (proxy template)
    link '/etc/awslogs' do
      to '/var/awslogs/etc'
      owner 'root'
      group 'root'
    end

    local_download_temp = node['bonusbits_base']['local_file_cache']
    # Deploy AWS CloudWatch Logs Config
    ## Dumb non-interactive option requires a awslogs.conf.
    ## Instead of letting you write it after install and restarting service. So, this is the workaround
    ## This is basically the awslogs.conf put in a temp location and renamed
    template "#{local_download_temp}/cwlogs.cfg" do
      source 'cloudwatch_logs/awslogs.conf.erb'
      owner 'root'
      group 'root'
      mode '0644'
      notifies :restart, 'service[awslogs]', :delayed if ec2_deployment
    end

    # Install CloudWatch Logs Agent
    ruby_block 'Download CloudWatch Logs Agent Setup Script' do
      block do
        download_url = 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'
        shell_command = "curl -k #{download_url} -o #{local_download_temp}/awslogs-agent-setup.py"
        successful = BonusBits::Shell.run_command(shell_command)
        raise 'ERROR: Failed to Download CloudWatch Logs Agent Setup Script!' unless successful
      end
      action :run
      not_if { ::File.exist?("#{local_download_temp}/awslogs-agent-setup.py") }
      notifies :run, 'ruby_block[run_cloudwatch_logs_agent_setup]', :immediately
    end

    # Run Agent Setup
    ruby_block 'run_cloudwatch_logs_agent_setup' do
      block do
        shell_command = "python #{local_download_temp}/awslogs-agent-setup.py -n -r"
        shell_command += " #{node['bonusbits_base']['aws']['region']} -c #{local_download_temp}/cwlogs.cfg"
        successful = BonusBits::Shell.run_command(shell_command)
        raise 'ERROR: Failed to Run Cloudwatch Logs Agent Setup!' unless successful
      end
      action :nothing
      not_if { ::File.exist?('/etc/init.d/awslogs') }
    end

    # Deploy AWS Config
    # Diff aws cli config name then RPM Install
    template '/var/awslogs/etc/aws.conf' do
      source 'cloudwatch_logs/awscli.conf.erb'
      owner 'root'
      group 'root'
      mode '0644'
    end

    # Deploy AWS CloudWatch Logs Config
    ## Diff State file path then RPM Install
    template '/var/awslogs/etc/awslogs.conf' do
      source 'cloudwatch_logs/awslogs.conf.erb'
      owner 'root'
      group 'root'
      mode '0644'
      variables(
        state_file: '/var/awslogs/state/agent-state'
      )
      notifies :restart, 'service[awslogs]', :delayed
      only_if { ec2_deployment } # Template calls ohai ec2
    end
  else
    return
  end

  # Deploy AWS CloudWatch Logs Proxy Config
  template '/etc/awslogs/proxy.conf' do
    source 'cloudwatch_logs/proxy.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[awslogs]', :delayed if ec2_deployment
    only_if { node['bonusbits_base']['proxy']['configure'] }
  end

  # Define Service
  service 'awslogs' do
    service_name 'awslogs'
    action %i[enable start]
    only_if { ec2_deployment }
  end
when 'windows'
  return
else
  return
end
