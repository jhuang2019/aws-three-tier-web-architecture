
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

variable "public_subnet_2a_id" {
  description = "id of the public subnet in AZ zone 2a"  
  type = string
}