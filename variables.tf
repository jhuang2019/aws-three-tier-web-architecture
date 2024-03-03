variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-2"
}

################################################################################
# VPC Module - Variables 
################################################################################

variable "vpc_id" {
  description = "The VPC to be deployed"
  type        = string
  default     = "aws_vpc.main.id"  
}

variable "vpc_cidr" {
  description = "The VPC Network Range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default = ["10.0.10.0/24", "10.0.20.0/24" ]
}

variable "private_subnet" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default = ["10.0.100.0/24", "10.0.200.0/24"]
}

variable "availability_zones" {
  description = "Availability Zones used"
  default     = ["ap-southeast-2a", "ap-southeast-2c"]
}

variable "cidr_block" {
  description = "CIDR Block to allow traffic via"
  type        = string
  default     = "0.0.0.0/0"
}

variable "gateway_id" {
  description = "Identifier of the VPC Internet Gateway"
  type        = string
  default     = "aws_internet_gateway.main.id"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "ec2_security_group_name" {
  description = "security group for EC2 instances"
  type        = string
  default     = "ec2-instance-security-group"
}

variable "web_alb_security_group_name" {
  description = "security group for application load balancers"
  type        = string
  default     = "web-ALB-SG"
}

################################################################################
# EC2 Module - Variables 
################################################################################

variable "image_id" {
  description = "Image ID"
  type        = string
  default     = "ami-07e1aeb90edb268a3"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "app_alb_name" {
  description = "Name of Application Load Balancer"
  type = string
  default = "Web-ALB"
}

variable "alb_internal" {
  description = "Application Load Balancer Network Type"
  type = string 
  default = "false"
}

variable "load_balancer_type" {
  description = "The type of Load Balancer"
  type = string
  default = "application"
}

/*variable "alb_security_group" {
  description = "Application Load Balancer Security Group"
  type = string
}*/

variable "load_balancer_arn" {
  description = "Application Load Balancer ARN"
  type = string
  default = "aws_lb.main.arn"
}

variable "alb_listener_port" {
  description = "Application Load Balancer Listener Port"
  type = string
  default = "80"
}

variable "alb_listener_protocol" {
  description = "Application Load Balancer Listener Protocol"
  type = string
  default ="HTTP"
}

variable "alb_listener_type" {
  description = "Application Load Balancer Listener Type"
  type =string
  default ="forward"
}

variable "alb_target_group_arn" {
  description = "Application Load Balancer Target Group ARN"
  type = string
  default = "aws_lb_target_group.main.arn"
}

variable "alb_target_group" {
  description = "Application Load Balancer Target Group"
  type = string
  default = "web-TG"
}

variable "alb_target_group_port" {
  description = "Application Load Balancer Target Group Port"
  type = string
  default = "80"
}

variable "alb_target_group_protocol" {
  description = "Application Load Balancer Target Protocol"
  type = string
  default = "HTTP"
}