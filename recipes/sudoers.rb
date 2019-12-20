case node['os']
when 'linux'
  package 'sudo'
  # Add /usr/local/bin to sudoers Secure Path
  ruby_block 'Add /usr/local/bin to sudoers Secure Path' do
    block do
      bash_command = 'sed -i "s/secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin$/secure_path = \/sbin:\/bin:\/usr\/sbin:\/usr\/bin:\/usr\/local\/bin/g" /etc/sudoers'

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
    # TODO: NOT WORKING
    not_if { ::File.readlines('/etc/sudoers').grep(%r{^secure_path = /sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin$}).any? }
  end
else
  return
end
