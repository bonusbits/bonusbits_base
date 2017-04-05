case node['os']
when 'linux'
  # TODO: Something is Funked.
  template '/usr/local/bin/nodeinfo' do
    source 'node_info/nodeinfo.sh.erb'
    owner 'root'
    group 'root'
    mode '0755'
  end
when 'windows'
  template 'C:/Windows/System32/nodeinfo.cmd' do
    source 'node_info/nodeinfo.cmd.erb'
  end
else
  return
end
