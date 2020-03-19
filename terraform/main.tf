terraform {
  required_providers {
    aws    = "~> 2.44.0"
    null   = "~> 2.1.2"
    random = "~> 2.2.1"
  }
}

module "vpc" {
  source          = "./modules/vpc"
  env             = var.env
  vpc             = var.vpc
  region          = var.env.region
}

module "elb_web" {
  source = "./modules/elb"
  asg             = var.asg_web
  elb             = var.elb_web
  env             = var.env
  region          = var.env.region
  security_group  = module.vpc.security_group_default
  subnet_ids      = module.vpc.public_subnet_ids
}

module "asg_web" {
  source          = "./modules/asg"
  asg             = var.asg_web
  env             = var.env
  region          = var.env.region
  vpc_id          = module.vpc.vpc_id
  security_group  = module.vpc.security_group_default
  subnet_ids      = module.vpc.private_subnet_ids
  elb_id          = module.elb_web.elb_id
}