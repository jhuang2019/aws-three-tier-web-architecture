output "vpc_id" {
  description = "The VPC to be deployed"
  value = aws_vpc.main.id
}

output "gateway_id" {
  description = "Identifier of the VPC Internet Gateway" 
  value = aws_internet_gateway.main.id
}