output "vpc_id" {
  description = "The VPC to be deployed"
  value = aws_vpc.main.id
}

output "gateway_id" {
  description = "VPC Internet Gateway" 
  value = aws_internet_gateway.main.id
}

output "ec2_security_group_name" {
  description = "The security group for EC2 instances"
  value = aws_security_group.ec2_sg.id
}

output "public_subnet_2a_id" {
  description = "public subnet 2a"
  value = aws_subnet.public_subnet_2a.id
}

output "public_subnet_2c_id" {
  description = "public subnet 2c"
  value = aws_subnet.public_subnet_2c.id
}

output "private_subnet_2a_id" {
  description = "private subnet 2a"
  value = aws_subnet.private_subnet_2a.id
}

output "private_subnet_2c_id" {
  description = "public subnet 2c"
  value = aws_subnet.private_subnet_2c.id
}

output "web_alb_security_group_name" {
  description = "the security group for application load balancers"
  value = aws_security_group.web_alb_sg.id
}

output "asg_web_inst_security_group_name" {
  description = "the security group for instances created through the launch template"
  value = aws_security_group.asg_web_inst_sg.id
}
