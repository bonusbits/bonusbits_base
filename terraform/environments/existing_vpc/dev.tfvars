# Common
env = {
  name = "levons"
  owner = "levon.becker@getalma.com"
  project = "terraform_demo"
  environment = "dev"
  region = "us-west-2"
}

# VPC
vpc = {
  enable_ipv6       = ["false"]
  cidr              = ["10.0.0.0/16"]
  az                = ["us-west-2a", "us-west-2b", "us-west-2c"]
  public_subnets    = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  private_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# EC2 Instances
asg_ui = {
  ami                     = ["ami-08d489468314a58df"]
  name                    = ["ui"]
  type                    = ["t3.small"]
  min_capacity            = [2]
  max_capacity            = [4]
  desired_capacity        = [2]
  timeout                 = [0]
  health_check_type       = ["EC2"]
  root_volume_size        = [25]
  second_volume_size      = [25]
}

# ELB
elb_ui = {
  instance_port       = "80"
  instance_protocol   = "HTTP"
  lb_port             = "80"
  lb_protocol         = "HTTP"
  health_check_target = "HTTP:80/"
}
