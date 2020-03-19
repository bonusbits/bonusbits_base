provider "aws" {
  region = var.region
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
  //  tags = {
  //    Name = "${var.env.name}_${var.env.environment}_default"
  //  }
}

locals {
  name = "${var.env.name}-${var.env.environment}"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.21.0"

  name = local.name

  cidr = element(var.vpc.cidr, 0)

  azs             = var.vpc.az
  private_subnets = var.vpc.private_subnets
  public_subnets  = var.vpc.public_subnets
  enable_ipv6     = element(var.vpc.enable_ipv6, 0)

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  # VPC endpoint for S3
  enable_s3_endpoint = true

  # VPC endpoint for DynamoDB
  enable_dynamodb_endpoint = true

  # VPC Endpoint for EC2
  enable_ec2_endpoint              = true
  ec2_endpoint_private_dns_enabled = true
  ec2_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC Endpoint for EC2MESSAGES
  enable_ec2messages_endpoint              = true
  ec2messages_endpoint_private_dns_enabled = true
  ec2messages_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC Endpoint for ECR API
  enable_ecr_api_endpoint              = true
  ecr_api_endpoint_private_dns_enabled = true
  ecr_api_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC Endpoint for ECR DKR
  enable_ecr_dkr_endpoint              = true
  ecr_dkr_endpoint_private_dns_enabled = true
  ecr_dkr_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for KMS
  enable_kms_endpoint              = true
  kms_endpoint_private_dns_enabled = true
  kms_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for ECS
  enable_ecs_endpoint              = true
  ecs_endpoint_private_dns_enabled = true
  ecs_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for ECS telemetry
  enable_ecs_telemetry_endpoint              = true
  ecs_telemetry_endpoint_private_dns_enabled = true
  ecs_telemetry_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # VPC endpoint for SQS
  enable_sqs_endpoint              = true
  sqs_endpoint_private_dns_enabled = true
  sqs_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # Tags
  public_subnet_tags = {
    Name = "${var.env.name}_public"
  }

  private_subnet_tags = {
    Name = "${var.env.name}_private"
  }

  tags = {
    Environment = var.env.environment
    Owner       = var.env.owner
    Project     = var.env.project
  }

  vpc_tags = {
    Name = local.name
  }

  vpc_endpoint_tags = {
    Endpoint = "true"
  }
}