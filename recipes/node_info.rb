# Node Info Script
template '/usr/local/bin/nodeinfo' do
  source 'node_info/nodeinfo.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Node Attributes JSON
node_bonusbits_base = node['bonusbits_base'].to_hash

file 'node attributes to json' do
  path '/etc/chef/.chef-attributes.json'
  backup false
  content(
    Chef::JSONCompat.to_json_pretty(
      'bonusbits_base' => node_bonusbits_base
    )
  )
  mode '0775'
  sensitive true
end
