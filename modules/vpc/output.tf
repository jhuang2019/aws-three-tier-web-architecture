output "vpc_id" {
  description = "The VPC to be deployed"
  value = aws_vpc.main.id
}

output "gateway_id" {
  description = "Identifier of the VPC Internet Gateway" 
  value = aws_internet_gateway.main.id
}

output "ec2_security_group_name" {
  description = "EC2 Instance Security Group"
  value = aws_security_group.ec2_sg.id
}

output "public_subnet_2a_id" {
  description = "EC2 Instance Security Group"
  value = aws_subnet.public_subnet_2a.id
}