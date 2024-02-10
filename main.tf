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
  route_table_id       = var.route_table_id
  gateway_id           = module.vpc.gateway_id
  subnet_id            = var.subnet_id
  enable_dns_hostnames = true
  enable_dns_support   = true
}