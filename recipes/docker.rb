# Deploy DNS Update Script (For awslogs init script)
template '/etc/sysconfig/network' do
  source 'docker/sysconfig.network.erb'
  owner 'root'
  group 'root'
  mode '0644'
  not_if { ::File.exist?('/etc/sysconfig/network') }
end
