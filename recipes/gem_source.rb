# Deploy .gemrc file
case node['os']
when 'linux'
  # Set System Root RubyGem Source
  gemrc_path = '/root/.gemrc'
  template gemrc_path do
    source 'gem_source/gemrc.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end

  # Set Chef RubyGem Source # TODO: This needed with above?
  ruby_block 'Set Chef RubyGem Source' do
    block do
      source_url = node['bonusbits_base']['gem_source']['source_url']
      bash_command = "/opt/chef/embedded/bin/gem sources -r https://rubygems.org/ && /opt/chef/embedded/bin/gem sources -a #{source_url}"

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
    only_if do
      require 'open3'
      bash_command = '/opt/chef/embedded/bin/gem sources'
      out, _err, _status = Open3.capture3(bash_command)
      out.match(%r{https://rubygems.org/})
    end
  end
when 'windows'
  gemrc_path = "#{ENV['USERPROFILE']}/.gemrc"
  template gemrc_path do
    source 'gem_source/gemrc.erb'
  end
else
  raise 'OS Family = Unknown'
end
