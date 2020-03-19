# ELB DNS name
output "elb_dns_name" {
  description = "DNS Name of the ELB"
  value       = module.elb.this_elb_dns_name
}

# ELB ID
output "elb_id" {
  description = "ELB ID"
  value       = module.elb.this_elb_id
}