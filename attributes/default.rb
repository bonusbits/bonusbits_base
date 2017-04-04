# Determine Environment
run_state['detected_environment'] =
  if /dev|qa|stg|prd/ =~ node.environment
    /dev|qa|stg|prd/.match(nodeenvironment).to_s.downcase
  else
    # Consider _default as 'Dev'
    'dev'
  end

# Deployment Type
default['bonusbits_base']['deployment_type'] = 'ec2'

# Debug
message_list = [
  '',
  '** Default **',
  "INFO: Detected Environment  (#{run_state['detected_environment']})",
  "INFO: Deployment Type       (#{node['bonusbits_base']['deployment_type']})"
]
message_list.each do |message|
  Chef::Log.warn(message)
end
