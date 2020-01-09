# Node Info Script
template '/usr/local/bin/nodeinfo' do
  source 'node_info/nodeinfo.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Node Attributes JSON
file 'node attributes to json' do
  path '/etc/chef/.chef-attributes.json'
  backup false
  content(Chef::JSONCompat.to_json_pretty(node.to_hash))
  mode '0775'
  sensitive true
end
