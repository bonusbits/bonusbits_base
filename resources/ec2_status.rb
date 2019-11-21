resource_name :ec2_status

property :aws_region, String, default: node['bonusbits_base']['aws']['region']
property :instance_id, String, default: node['bonusbits_base']['aws']['instance_id']
property :indicator_file, String, default: node['bonusbits_base']['ec2_status']['indicator_file']

action :check_status do
  BonusBits::Aws.check_ec2_status(new_resource.aws_region, new_resource.instance_id, new_resource.indicator_file)
end

default_action :check_status
