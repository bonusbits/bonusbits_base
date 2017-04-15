inside_aws = node['bonusbits_base']['aws']['inside']

case node['os']
when 'linux'
  case node['platform']
  when 'amazon'
    # Install CloudWatch Logs Agent
    package 'awslogs'
  when 'centos', 'redhat', 'ubuntu' # ~FC024
    package 'python'

    # TODO: Needed?
    directory '/etc/awslogs' do
      owner 'root'
      group 'root'
      mode '0755'
    end

    local_download_temp = node['bonusbits_base']['local_file_cache']
    # Install CloudWatch Logs Agent
    ruby_block 'Install CloudWatch Logs Agent' do
      block do
        download_url = 'https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py'
        bash_command = "curl #{download_url} -o #{local_download_temp}/awslogs-agent-setup.py"

        # Run Bash Script and Capture StrOut, StrErr, and Status
        require 'open3'
        Chef::Log.warn("Open3: BASH Command (#{bash_command})")
        out, err, status = Open3.capture3(bash_command)
        Chef::Log.warn("Open3: Status (#{status})")
        Chef::Log.warn("Open3: Standard Out (#{out})")
        unless status.success?
          Chef::Log.warn("Open3: Error Out (#{err})")
          raise 'Failed!'
        end
      end
      action :run
      not_if { ::File.exist?("#{local_download_temp}/awslogs-agent-setup.py") }
    end

    # Run Agent Setup
    ruby_block 'Run CloudWatch Logs Agent Setup' do
      block do
        bash_command = "python #{local_download_temp}/awslogs-agent-setup.py --region #{node['bonusbits_base']['aws']['region']} --non-interactive --configfile=/etc/awslogs/awscli.conf"

        # Run Bash Script and Capture StrOut, StrErr, and Status
        require 'open3'
        Chef::Log.warn("Open3: BASH Command (#{bash_command})")
        out, err, status = Open3.capture3(bash_command)
        Chef::Log.warn("Open3: Status (#{status})")
        Chef::Log.warn("Open3: Standard Out (#{out})")
        unless status.success?
          Chef::Log.warn("Open3: Error Out (#{err})")
          raise 'Failed!'
        end
      end
      action :run
      # not_if { ::File.exist?(?????) } # TODO: Add Condition or want to blow up if not there?
    end

    # Deploy AWS CloudWatch Logs Init Script
    template '/etc/init.d/awslogs' do
      source 'cloudwatch_logs/awslogs.init.sh.erb'
      owner 'root'
      group 'root'
      mode '0755'
      notifies :restart, 'service[awslogs]', :delayed if inside_aws
    end
  else
    return
  end

  # Deploy AWS CLI Config
  template '/etc/awslogs/awscli.conf' do
    source 'cloudwatch_logs/awscli.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[awslogs]', :delayed if inside_aws
  end

  # Deploy AWS CloudWatch Logs Proxy Config
  template '/etc/awslogs/proxy.conf' do
    source 'cloudwatch_logs/proxy.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[awslogs]', :delayed if inside_aws
    only_if { node['bonusbits_base']['proxy']['configure'] }
  end

  # Deploy AWS CloudWatch Logs Config
  template '/etc/awslogs/awslogs.conf' do
    source 'cloudwatch_logs/awslogs.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    notifies :restart, 'service[awslogs]', :delayed
    only_if { inside_aws } # Ohai EC2 Plugin Used
  end

  # Define Service
  service 'awslogs' do
    service_name 'awslogs'
    action [:enable]
    only_if { node['bonusbits_base']['aws']['inside'] }
  end
when 'windows'
  return
else
  return
end
