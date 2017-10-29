# !! JUST EXAMPLE CODE - No Real info in Test Data Bag !!
# TODO: Parameterize Values to make actually work based on overrides
# TODO: Chain Support?

# Staged Variables to Setup as Attributes TODO: Setup Loop for more than one cert?
crt_filename = 'internal-ca.crt'
cert_alias = 'internalca'

# Fetch Data Bag
data_bag = node['bonusbits_base']['certs']['data_bag']
data_bag_item = node['bonusbits_base']['certs']['data_bag_item']
node.run_state['certs_data_bag'] = data_bag_item(data_bag, data_bag_item)

# OS
template "/etc/pki/tls/certs/#{crt_filename}" do
  source 'certs/cert.erb'
  owner 'root'
  group 'root'
  mode '0644'
  sensitive true
  variables(
    pem: node.run_state['certs_data_bag']['pem']
  )
end

link "/etc/pki/tls/certs/#{node.run_state['certs_data_bag']['hash']}" do
  to "/etc/pki/tls/certs/#{crt_filename}"
  owner 'root'
  group 'root'
end

# Chef
template "/opt/chef/embedded/ssl/certs/#{crt_filename}" do
  source 'certs/cert.erb'
  owner 'root'
  group 'root'
  mode '0664'
  sensitive true
  variables(
    pem: node.run_state['certs_data_bag']['pem']
  )
end

link "/opt/chef/embedded/ssl/certs/#{node.run_state['certs_data_bag']['hash']}" do
  to "/opt/chef/embedded/ssl/certs/#{crt_filename}"
  owner 'root'
  group 'root'
end

# Java (Required: Java Installed Prior so keytool is installed...)
ruby_block 'Install Internal CA Certificate to Java Keystore' do
  block do
    deployment_environment = node['bonusbits_base']['deployment_environment']
    keystore_password = node.run_state['certs_data_bag']['keystore_password'][deployment_environment]
    # Check if already imported
    check_command = "keytool -list -keystore /etc/pki/ca-trust/extracted/java/cacerts -storepass #{keystore_password} -alias #{cert_alias}"
    cert_found = BonusBits::Shell.run_command(check_command, true)

    unless cert_found
      import_command = "keytool -importcert -file /etc/pki/tls/certs/#{crt_filename} -keystore /etc/pki/ca-trust/extracted/java/cacerts -storepass #{keystore_password} -alias #{cert_alias}"
      successful = BonusBits::Shell.run_command(import_command, true)
      raise 'ERROR: Importing Internal CA Certificate to Java Keystore!' unless successful
    end
  end
  only_if { node['bonusbits_base']['java']['configure'] }
end
