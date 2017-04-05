ENV['http_proxy'] = node['bonusbits_base']['proxy']['url']
ENV['https_proxy'] = node['bonusbits_base']['proxy']['url']
ENV['no_proxy'] = node['bonusbits_base']['proxy']['no_proxy']

case node['os']
when 'linux'
  configure_proxy = node['bonusbits_base']['proxy']['configure']
  if configure_proxy
    # Add Proxy to Vagrant Shell Environment
    template '/etc/environment' do
      source 'proxy/linux.erb'
      owner 'root'
      group 'root'
      mode 0o0644
      notifies :run, 'execute[source_environment_file]', :immediately
    end

    execute 'source_environment_file' do
      command '. /etc/environment'
      action :nothing
    end
  end
when 'windows'
  return
else
  return
end
