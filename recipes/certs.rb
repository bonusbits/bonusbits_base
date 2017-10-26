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
  to '/etc/pki/tls/certs/internal-ca.crt'
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

# Java (If Installing Java)
if node['bonusbits_base']['java']['configure']
  ruby_block 'install_aws_ldap_certificate' do
    block do
      secrets_env = node['bonusbits_base']['deployment_environment']
      keystore_password = node.run_state['secrets']['cof_aws_ldap_ca']['keystore_password'][secrets_env]
      # Check if already imported
      check_command = "keytool -list -keystore /etc/pki/ca-trust/extracted/java/cacerts -storepass #{keystore_password} -alias awscofldapca"
      cert_found = C1Jenkins2x::Shell.run_command(check_command, true)

      unless cert_found
        import_command = "keytool -importcert -file /etc/pki/tls/certs/cof-aws-ldap-ca.crt -keystore /etc/pki/ca-trust/extracted/java/cacerts -storepass #{keystore_password} -alias awscofldapca"
        successful = C1Jenkins2x::Shell.run_command(import_command, true)
        raise 'ERROR: Importing LDAP Certificate to Keystore!' unless successful
      end
    end
    action :run
    only_if { role == 'master' || role == 'joc' }
  end
end
