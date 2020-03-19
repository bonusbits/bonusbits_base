# Launch configuration
output "launch_configuration_id" {
  description = "The ID of the launch configuration"
  value       = module.asg.this_launch_configuration_id
}

# Autoscaling group
output "autoscaling_group_id" {
  description = "The autoscaling group id"
  value       = module.asg.this_autoscaling_group_id
}
