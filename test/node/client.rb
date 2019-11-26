checksum_path '/etc/chef/checksums'
chef_license 'accept'
chef_server_url 'http://127.0.0.1:8889'
cookbook_path '/etc/chef/cookbooks'
data_bag_path '/etc/chef/data_bags'
encrypted_data_bag_secret '/etc/chef/data_bags/encrypted_data_bag_secret'
environment_path '/etc/chef/environments'
file_backup_path '/etc/chef/backup'
file_cache_path '/etc/chef/cache'
log_level :info
log_location '/var/log/chef-client.log'
node_name 'docker_node'
role_path '/etc/chef/roles'
treat_deprecation_warnings_as_errors false
verify_api_cert false

# chef_zero.enabled true
# local_mode true
# client_key '/tmp/kitchen/client.pem'
# client_path '/tmp/kitchen/clients'
# named_run_list {}
# node_path '/tmp/kitchen/nodes'
# user_path '/tmp/kitchen/users'
# validation_key '/tmp/kitchen/validation.pem'
