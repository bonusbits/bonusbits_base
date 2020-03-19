provider "aws" {
  region = var.region
}

locals {
  name = "${var.env.name}-${var.env.environment}-${element(var.asg.name, 0)}"
}

######
# ELB
######
module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"

  name = local.name

  subnets         = var.subnet_ids
  security_groups = [var.security_group.id]
  internal        = false

  listener = [
    {
      instance_port     = var.elb.instance_port
      instance_protocol = var.elb.instance_protocol
      lb_port           = var.elb.lb_port
      lb_protocol       = var.elb.lb_protocol
    },
  ]

  health_check = {
    target              = var.elb.health_check_target
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  tags = {
    Environment = var.env.environment
    Owner       = var.env.owner
    Project     = var.env.project
  }
}