provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/vpc"
  vpc_id               = module.vpc.vpc_id
  vpc_cidr             = var.vpc_cidr
  public_subnet        = var.public_subnet
  private_subnet       = var.private_subnet
  availability_zones   = var.availability_zones
  cidr_block           = var.cidr_block
  gateway_id           = module.vpc.gateway_id
  enable_dns_hostnames = true
  enable_dns_support   = true
  ec2_security_group_name = var.ec2_security_group_name
}

module "ec2" {
  source             = "./modules/ec2"
  image_id           = var.image_id
  instance_type      = var.instance_type
  ec2_security_group = module.vpc.ec2_security_group_name
  public_subnet_2a_id = module.vpc.public_subnet_2a_id
}