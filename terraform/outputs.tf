# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# Security Groups
output "security_group_default" {
  description = "List of IDs of private subnets"
  value       = module.vpc.security_group_default
}

# Subnets
output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

# NAT gateways
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# AZs
output "azs" {
  description = "A list of availability zones spefified as argument to this module"
  value       = module.vpc.azs
}

//# Launch configuration
//output "launch_configuration_id" {
//  description = "The ID of the launch configuration"
//  value       = module.asg.launch_configuration_id
//}
//
//# Autoscaling group
//output "autoscaling_group_id" {
//  description = "The autoscaling group id"
//  value       = module.asg.autoscaling_group_id
//}

# ELB DNS name
output "elb_web_dns_name" {
  description = "DNS Name of the ELB"
  value       = module.elb_web.elb_dns_name
}