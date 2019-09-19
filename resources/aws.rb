# New Custom Resources Syntax 12.5+
# property :name, String, default: 'value'

# Examples Not Really for Use (Basic Logic that could be used to call the library directly from recipe)

action :fetch_az do
  results = BonusBits::AWS.fetch_metadata('availability-zone')
  BonusBits::Output.report "Availability Zone (#{results})"
end

action :fetch_region do
  results = BonusBits::AWS.fetch_metadata('region')
  BonusBits::Output.report "Region (#{results})"
end

action :fetch_ami_id do
  results = BonusBits::AWS.fetch_metadata('ami-id')
  BonusBits::Output.report "AMI ID (#{results})"
end

action :fetch_instance_type do
  results = BonusBits::AWS.fetch_metadata('instance-type')
  BonusBits::Output.report "AMI ID (#{results})"
end

action :fetch_local_hostname do
  results = BonusBits::AWS.fetch_metadata('local-hostname')
  BonusBits::Output.report "Local Hostname (#{results})"
end

action :fetch_public_hostname do
  results = BonusBits::AWS.fetch_metadata('public-hostname')
  BonusBits::Output.report "AMI ID (#{results})"
end

action :fetch_local_ipv4 do
  results = BonusBits::AWS.fetch_metadata('local-ipv4')
  BonusBits::Output.report "AMI ID (#{results})"
end

action :fetch_public_ipv4 do
  results = BonusBits::AWS.fetch_metadata('public-ipv4')
  BonusBits::Output.report "AMI ID (#{results})"
end

action :fetch_security_groups do
  results = BonusBits::AWS.fetch_metadata('security-groups')
  BonusBits::Output.report "AMI ID (#{results})"
end
