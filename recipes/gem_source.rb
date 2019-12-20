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

  chef_path = node['bonusbits_base']['chef_path']

  # Set Chef RubyGem Source # TODO: This needed with above?
  ruby_block 'Set Chef RubyGem Source' do
    block do
      source_url = node['bonusbits_base']['gem_source']['source_url']
      shell_command = "#{chef_path}/embedded/bin/gem sources -r https://rubygems.org/"
      shell_command += " && #{chef_path}/embedded/bin/gem sources -a #{source_url}"
      successful = BonusBits::Shell.run_command(shell_command)
      raise 'ERROR: Failed to Set Chef RubyGem Source!' unless successful
    end
    action :nothing
    only_if do
      require 'open3'
      shell_command = "#{chef_path}/embedded/bin/gem sources"
      out, _err, _status = Open3.capture3(shell_command)
      out =~ %r{https://rubygems.org/}
    end
  end
else
  raise 'OS Family = Unknown'
end
