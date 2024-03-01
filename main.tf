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
}