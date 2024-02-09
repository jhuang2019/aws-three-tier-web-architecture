output "vpc_id" {
  description = "The VPC to be deployed"
  value = aws_vpc.main.id
}