variable asg {
  type = map
}

variable env {
  type = map
}

variable region {
  type    = string
  default = "us-west-2"
}

# VPC Module Outputs
variable "vpc_id" {}
variable "security_group" {}
variable "subnet_ids" {}

# ELB Module Outputs
variable "elb_id" {}