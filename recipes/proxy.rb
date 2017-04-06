ENV['http_proxy'] = node['bonusbits_base']['proxy']['url']
ENV['https_proxy'] = node['bonusbits_base']['proxy']['url']
ENV['no_proxy'] = node['bonusbits_base']['proxy']['no_proxy']

case node['os']
when 'linux'
  configure_proxy = node['bonusbits_base']['proxy']['configure']
  if configure_proxy
    # # Add Proxy to Vagrant Shell Environment
    # template '/etc/environment' do
    #   source 'proxy/environment.sh.erb'
    #   owner 'root'
    #   group 'root'
    #   mode 0o0644
    #   notifies :run, 'execute[source_environment_file]', :immediately
    # end
    #
    # execute 'source_environment_file' do
    #   command '. /etc/environment'
    #   action :nothing
    # end

    # Deploy Profile Script
    template '/etc/profile.d/proxy.sh' do
      source 'proxy/proxy.sh.erb'
      owner 'root'
      group 'root'
      mode '0644'
      only_if { node['bonusbits_base']['proxy']['configure'] }
      notifies :run, 'execute[source_proxy_profile_script]', :immediately
    end

    # Run Profile Script
    ruby_block 'source_proxy_profile_script' do
      block do
        bash_command = '. /etc/profile.d/proxy.sh'

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
      action :nothing
      not_if do
        ENV['http_proxy'] == node['bonusbits_base']['proxy']['url'] &&
          ENV['https_proxy'] == node['bonusbits_base']['proxy']['url'] &&
          ENV['no_proxy'] == node['bonusbits_base']['proxy']['no_proxy']
      end
    end
  end
when 'windows'
  return
else
  return
end
