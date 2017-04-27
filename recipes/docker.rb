# Deploy Network Config for Docker (For init script looking for /etc/sysconfig/network)
template '/etc/sysconfig/network' do
  source 'docker/sysconfig.network.erb'
  owner 'root'
  group 'root'
  mode '0644'
  not_if { ::File.exist?('/etc/sysconfig/network') }
end
