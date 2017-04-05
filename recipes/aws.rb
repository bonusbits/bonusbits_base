case node['os']
when 'linux'
  case node['platform']
  when 'redhat'
    # Install Pip (Requires EPEL)
    package 'python-pip'
    # Install with curl
    # 'curl -O https://bootstrap.pypa.io/get-pip.py'
    # 'python3 get-pip.py --user'

    # Deploy Bash Profile Script for AWS CLI Pip Install Path
    template '/etc/profile.d/awscli.sh' do
      source 'aws_tools/awscli.sh.erb'
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
        bash_command = 'pip install --upgrade awscli -t /opt/awscli'

        # Run Bash Script and Capture StrOut, StrErr, and Status
        require 'open3'
        Chef::Log.warn("Open3: BASH Command (#{bash_command})")
        out, err, status = Open3.capture3(bash_command)
        Chef::Log.warn("Open3: Status (#{status})")
        unless status.success?
          Chef::Log.warn("Open3: Standard Out (#{out})")
          Chef::Log.warn("Open3: Error Out (#{err})")
          raise 'Failed!'
        end
      end
      action :run
      not_if { `aws --version`.match(%r{^aws-cli/1*}) } # ~FC048
    end
  else
    return
  end
when 'windows'
  return
else
  return
end
