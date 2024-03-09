################################################################################
# VPC
################################################################################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "VPC-Lab"
  }
}

# Public subnet 1
resource "aws_subnet" "public_subnet_2a" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.public_subnet, 0)
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "public-subnet-2a"
  }
}

# Public subnet 2
resource "aws_subnet" "public_subnet_2c" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.public_subnet, 1)
  availability_zone = "ap-southeast-2c"

  tags = {
    Name = "public-subnet-2c"
  }
}

# Private subnet 1
resource "aws_subnet" "private_subnet_2a" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.private_subnet, 0)
  availability_zone = "ap-southeast-2a"

  tags = {
    Name = "private-subnet-2a"
  }
}

# Private subnet 2
resource "aws_subnet" "private_subnet_2c" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.private_subnet, 1)
  availability_zone = "ap-southeast-2c"

  tags = {
    Name = "private-subnet-2c"
  }
}

#Internet Gateway for the Public Subnets
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = "Internet-Gateway"
  }
}

# Create an Elastic IP for NAT Gateway 1 
resource "aws_eip" "gw" {
  tags = {
    Name = "Elastic IP for Nat Gateway 1"
  }
  depends_on = [aws_internet_gateway.main]
}

# Create a NAT Gateway for the Availability Zone A
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.gw.id
  depends_on    = [aws_internet_gateway.main]
  subnet_id     = aws_subnet.public_subnet_2a.id

  tags = {
    Name = "Nat Gateway 1 for Availability Zone A"
  }
}

# Route Table for the Public Subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.cidr_block
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "Public-Route-Table"
  }
}

# Route table associations - Public
resource "aws_route_table_association" "public_route_table_a" {
  subnet_id      = aws_subnet.public_subnet_2a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_route_table_c" {
  subnet_id      = aws_subnet.public_subnet_2c.id
  route_table_id = aws_route_table.public_route_table.id
}

# First route table for the Private Subnet 1
resource "aws_route_table" "private_route_table_a" {
  vpc_id = var.vpc_id
  route {
    cidr_block = var.cidr_block
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private-Route-Table-2a"
  }
}

# Route table associations - Private
resource "aws_route_table_association" "private_route_table_a" {
  subnet_id      = aws_subnet.private_subnet_2a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

# Second route table for the Private Subnet 2
resource "aws_route_table" "private_route_table_c" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr_block
    gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "Private-Route-Table-2c"
  }
}

# Route table associations - Private
resource "aws_route_table_association" "private_route_table_c" {
  subnet_id      = aws_subnet.private_subnet_2c.id
  route_table_id = aws_route_table.private_route_table_c.id
}

# Create a security group for EC2 instances
resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_security_group_name
  description = "security group for EC2 instances"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }

  tags = {
    Name = "EC2-SG"
  }
}

# Create a security group for application load balancers
resource "aws_security_group" "web_alb_sg" {
  name        = var.web_alb_security_group_name
  description = "security group for application load balancers"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }

  tags = {
    Name = "web-ALB-SG"
  }
}

#Create a security group for the instances created through the launch template to use
resource "aws_security_group" "asg_web_inst_sg" {
  name        = var.asg_web_inst_security_group_name
  description = "security group for the instances created through the launch template"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Allow HTTP access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.cidr_block]
  }

  tags = {
    Name = "asg-web-inst-sg"
  }
}