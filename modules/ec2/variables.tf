variable "image_id" {
  description = "Image ID"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instances"
  type        = string
}

variable "ec2_security_group" {
  description = "security group for EC2 instances"
  type        = string
}

variable "public_subnet_2a_id" {
  description = "id of the public subnet in the AZ 2a"
  type        = string
}


/* create an application load balancer */
variable "app_alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
}

variable "alb_internal" {
  description = "Application Load Balancer Network Type"
  type        = string
}

variable "load_balancer_type" {
  description = "The type of Load Balancer"
  type        = string
}

variable "web_alb_security_group_name" {
  description = "security group for application load balancers"
  type        = string
}

variable "public_subnet_2c_id" {
  description = "id of the public subnet in the AZ 2c"
  type        = string
}

variable "load_balancer_arn" {
  description = "Application Load Balancer ARN"
  type        = string
}

variable "alb_listener_port" {
  description = "Application Load Balancer Listener Port"
  type        = string
}

variable "alb_listener_protocol" {
  description = "Application Load Balancer Listener Protocol"
  type        = string
}

variable "alb_listener_type" {
  description = "Application Load Balancer Listener Type"
  type        = string
}

variable "alb_target_group" {
  description = "Application Load Balancer Target Group"
  type        = string
}

variable "alb_target_group_port" {
  description = "Application Load Balancer Target Group Port"
  type        = string
}

variable "alb_target_group_protocol" {
  description = "Application Load Balancer Target Protocol"
  type        = string
}

variable "vpc_id" {
  description = "The VPC to be deployed"
  type        = string
}

/* configure launch template */
variable "asg_web_inst_security_group" {
  description = "security groups for ASG"
  type        = string
}

variable "private_subnet_2a_id" {
  description = "id of the private subnet in the AZ 2a"
  type        = string
}

variable "private_subnet_2c_id" {
  description = "id of the private subnet in the AZ 2c"
  type        = string
}
