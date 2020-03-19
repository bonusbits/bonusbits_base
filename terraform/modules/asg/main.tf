provider "aws" {
  region = var.region
}

locals {
  name = "${var.env.name}_${var.env.environment}_${element(var.asg.name, 0)}"
}

######
# Launch configuration and autoscaling group
######
module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 3.0"

  name = local.name

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  # create_lc = false # disables creation of launch configuration
  lc_name = local.name

  image_id        = element(var.asg.ami, 0)
  instance_type   = element(var.asg.type, 0)
  security_groups = [var.security_group.id]
  load_balancers  = [var.elb_id]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = element(var.asg.second_volume_size, 0)
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = element(var.asg.root_volume_size, 0)
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = local.name
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = element(var.asg.health_check_type, 0)
  min_size                  = element(var.asg.min_capacity, 0)
  max_size                  = element(var.asg.max_capacity, 0)
  desired_capacity          = element(var.asg.desired_capacity, 0)
  wait_for_capacity_timeout = element(var.asg.timeout, 0)

  tags = [
    {
      key                 = "Environment"
      value               = var.env.environment
      propagate_at_launch = true
    },
    {
      key                 = "Owner"
      value               = var.env.owner
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = var.env.project
      propagate_at_launch = true
    }
  ]
}
