
variable "image_id" {
  description = "Image ID"
  type = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type = string
}

variable "ec2_security_group" {
  description = "EC2 Security Group"
  type = string
}

variable "asg_web_inst_security_group" {
  description = "EC2 Security Group"
  type = string
}

variable "public_subnet_2a_id" {
  description = "id of the public subnet in AZ zone 2a"  
  type = string
}

variable "public_subnet_2c_id" {
  description = "id of the public subnet in AZ zone 2c"  
  type = string
}

variable "app_alb_name" {
  description = "Name of Application Load Balancer"
  type = string
}

variable "alb_internal" {
  description = "Application Load Balancer Network Type"
  type = string 
}

variable "load_balancer_type" {
  description = "The type of Load Balancer"
  type = string
}

variable "web_alb_security_group_name" {
  description = "Application Load Balancer Security Group"
  type = string
}

variable "load_balancer_arn" {
  description = "Application Load Balancer ARN"
  type = string
}

variable "alb_listener_port" {
  description = "Application Load Balancer Listener Port"
  type = string
}

variable "alb_listener_protocol" {
  description = "Application Load Balancer Listener Protocol"
  type = string
}

variable "alb_listener_type" {
  description = "Application Load Balancer Listener Type"
  type =string
}

variable "alb_target_group_arn" {
  description = "Application Load Balancer Target Group ARN"
  type = string
}

variable "alb_target_group" {
  description = "Application Load Balancer Target Group"
  type = string
}

variable "alb_target_group_port" {
  description = "Application Load Balancer Target Group Port"
  type = string
}

variable "alb_target_group_protocol" {
  description = "Application Load Balancer Target Protocol"
  type = string
}


variable "vpc_id" {
  description = "The VPC to be deployed"
  type = string
}

/*variable "app_autoscaling_group" {
  description = "Autoscaling Group Name"
  type = string
}*/