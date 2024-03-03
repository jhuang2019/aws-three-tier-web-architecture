variable "vpc_cidr" {
  description = "The VPC Network Range"
  type = string
}

variable "vpc_id" {
  description = "The VPC to be deployed"
  type = string
}

variable "availability_zones" {
  description = "Avaiability Zones used"
  type = list(string)
}

variable "public_subnet" {
  description = "A list of public subnets inside the VPC"
  type = list(string)
}

variable "private_subnet" {
  description = "A list of private subnets inside the VPC"
  type = list(string)
}

variable "cidr_block" {
  description = "CIDR Block to allow traffic via"
  type = string
}

variable "gateway_id" {
  description = "Identifier of the VPC Internet Gateway"
  type = string
}


variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
 
}

variable "ec2_security_group_name" {
  description ="security group for EC2 instances"
  type = string
}

variable "web_alb_security_group_name" {
  description ="security group for application load balancers"
  type = string
}