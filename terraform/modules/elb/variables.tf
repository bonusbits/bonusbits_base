variable asg {
  type = map
}

variable elb {
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
variable "security_group" {}
variable "subnet_ids" {}