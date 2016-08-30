# Deploy Node Info Script
template 'C:/Windows/System32/nodeinfo.cmd' do
  source 'nodeinfo.cmd.erb'
  only_if { node['bonusbits_base']['nodeinfo_script']['deploy'] }
end
