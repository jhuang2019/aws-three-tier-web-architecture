provider "aws" {
  region = var.region
}

module "vpc" {
  source                           = "./modules/vpc"
  vpc_id                           = module.vpc.vpc_id
  vpc_cidr                         = var.vpc_cidr
  public_subnet                    = var.public_subnet
  private_subnet                   = var.private_subnet
  availability_zones               = var.availability_zones
  cidr_block                       = var.cidr_block
  gateway_id                       = module.vpc.gateway_id
  enable_dns_hostnames             = true
  enable_dns_support               = true
  ec2_security_group_name          = var.ec2_security_group_name
  web_alb_security_group_name      = var.web_alb_security_group_name
  asg_web_inst_security_group_name = var.asg_web_inst_security_group_name
}

module "ec2" {
  /* create an EC2 instance */
  source              = "./modules/ec2"
  image_id            = var.image_id
  instance_type       = var.instance_type
  ec2_security_group  = module.vpc.ec2_security_group_name
  public_subnet_2a_id = module.vpc.public_subnet_2a_id
  /* create an application load balancer */
  app_alb_name                = var.app_alb_name
  alb_internal                = var.alb_internal
  load_balancer_type          = var.load_balancer_type
  web_alb_security_group_name = module.vpc.web_alb_security_group_name
  public_subnet_2c_id         = module.vpc.public_subnet_2c_id
  load_balancer_arn           = var.load_balancer_arn
  alb_listener_port           = var.alb_listener_port
  alb_listener_protocol       = var.alb_listener_protocol
  alb_listener_type           = var.alb_listener_type
  alb_target_group            = var.alb_target_group
  alb_target_group_port       = var.alb_target_group_port
  alb_target_group_protocol   = var.alb_target_group_protocol
  vpc_id                      = module.vpc.vpc_id
  /* configure launch templates */
  private_subnet_2a_id        = module.vpc.private_subnet_2a_id
  private_subnet_2c_id        = module.vpc.private_subnet_2c_id
  asg_web_inst_security_group = module.vpc.asg_web_inst_security_group_name
}