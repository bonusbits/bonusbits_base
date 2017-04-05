# Fetch Data Bag
data_bag = node['bonusbits_base']['certs']['data_bag']
data_bag_item = node['bonusbits_base']['certs']['data_bag_item']
node.run_state['certs_data_bag'] = data_bag_item(data_bag, data_bag_item)

# OS
template '/etc/pki/tls/certs/internal-ca.crt' do
  source 'certs/internal-ca.pem.erb'
  owner 'root'
  group 'root'
  mode '0644'
  sensitive true
end

link "/etc/pki/tls/certs/#{node.run_state['certs_data_bag']['hash']}" do
  to '/etc/pki/tls/certs/cof-aws-ldap-ca.crt'
  owner 'root'
  group 'root'
end

# Chef
template '/opt/chef/embedded/ssl/certs/internal-ca.crt' do
  source 'certs/internal-ca.pem.erb'
  owner 'root'
  group 'root'
  mode '0664'
  sensitive true
end

link "/opt/chef/embedded/ssl/certs/#{node.run_state['certs_data_bag']['hash']}" do
  to '/opt/chef/embedded/ssl/certs/internal-ca.crt'
  owner 'root'
  group 'root'
end
