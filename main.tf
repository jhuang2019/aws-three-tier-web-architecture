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
  web_alb_security_group_name = var.web_alb_security_group_name
  asg_web_inst_security_group_name = var.asg_web_inst_security_group_name
}

module "ec2" {
  source             = "./modules/ec2"
  image_id           = var.image_id
  instance_type      = var.instance_type
  ec2_security_group = module.vpc.ec2_security_group_name
  public_subnet_2a_id = module.vpc.public_subnet_2a_id
  public_subnet_2c_id = module.vpc.public_subnet_2c_id
  app_alb_name = var.app_alb_name
  alb_internal = var.alb_internal
  load_balancer_type = var.load_balancer_type
  web_alb_security_group_name = module.vpc.web_alb_security_group_name
  load_balancer_arn = var.load_balancer_arn
  alb_listener_port = var.alb_listener_port
  alb_listener_protocol = var.alb_listener_protocol
  alb_listener_type = var.alb_listener_type
  alb_target_group_arn = var.alb_target_group_arn
  alb_target_group = var.alb_target_group
  alb_target_group_port = var.alb_target_group_port
  alb_target_group_protocol = var.alb_target_group_protocol
  vpc_id = module.vpc.vpc_id
  asg_web_inst_security_group = module.vpc.asg_web_inst_security_group_name
}