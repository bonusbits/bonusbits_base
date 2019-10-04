ENV['AWS_REGION'] = node['bonusbits_base']['aws']['region']

# Deploy AWS Profile
case node['os']
when 'linux'
  # Run Profile Script
  ruby_block 'source_aws_profile_script' do
    block do
      shell_command = 'source /etc/profile.d/aws.sh'
      successful = BonusBits::Shell.run_command(shell_command)
      raise 'ERROR: Failed to Source AWS Profile Script!' unless successful
    end
    action :nothing
    not_if do
      ENV['AWS_REGION'] == node['bonusbits_base']['aws']['region']
    end
  end

  # Deploy Profile Script
  template '/etc/profile.d/aws.sh' do
    source 'aws/aws_profile.sh.erb'
    owner 'root'
    group 'root'
    mode '0644'
    only_if { node['bonusbits_base']['deployment_type'] == 'ec2' }
    notifies :run, 'ruby_block[source_aws_profile_script]', :immediately
  end
when 'windows'
  return
else
  return
end

# Deploy AWS Tools to Non Amazon Linux
if node['bonusbits_base']['aws']['install_tools']
  case node['platform']
  when 'redhat'
    package %w[python python-setuptools]

    # Install Latest Pip (~> 9.)
    ruby_block 'Install Pip' do
      block do
        shell_command = 'easy_install pip'
        successful = BonusBits::Shell.run_command(shell_command)
        raise 'ERROR: Failed to Install PIP!' unless successful
      end
      action :run
      not_if do
        shell_command = 'pip --version'
        out = BonusBits::Shell.run_command_return_strout(shell_command)
        out =~ /^pip 9\./
      end
    end

    # Deploy Bash Profile Script for AWS CLI Pip Install Path
    template '/etc/profile.d/awscli.sh' do
      source 'aws/awscli.sh.erb'
      owner 'root'
      group 'root'
      mode '0644'
    end
    # TODO: Path or Symlink
    # 'export PATH=~/.local/bin:$PATH'
    # '/etc/profile.d/awscli.sh' 0644

    # Install for root and ec2-user?

    # Install AWS CLI
    ruby_block 'Install AWS CLI' do
      block do
        shell_command = 'pip install --upgrade awscli -t /opt/awscli'
        successful = BonusBits::Shell.run_command(shell_command)
        raise 'ERROR: Failed to Install AWS CLI!' unless successful
      end
      action :nothing
      not_if { `aws --version`.match(%r{^aws-cli/1*}) } # ~FC048
    end
  else
    return
  end
end
