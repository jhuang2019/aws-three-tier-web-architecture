################################################################################
# VPC
################################################################################
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames                 = var.enable_dns_hostnames
  enable_dns_support                   = var.enable_dns_support

  tags = {
    Name = "VPC-Lab"
  }
}

# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = var.vpc_id
  for_each = var.public_subnet
  availability_zone = each.key
  cidr_block = each.value

  tags = { 
    Name = join(" ",["Public Subnet",each.key])   
  }
}

# Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  for_each          = var.private_subnet
  availability_zone = each.key
  cidr_block        = each.value

  tags = { 
    Name = join(" ",["Private Subnet",each.key])   
  }
}

#Internet Gateway for the Public Subnet
resource "aws_internet_gateway" "main" {
  vpc_id = var.vpc_id

  tags =  { 
    Name = "Internet-Gateway" 
  }
}

# Route Table for the Internet Gateway / Public Subnet
resource "aws_route_table" "main" {
  vpc_id = var.vpc_id
  for_each = var.public_subnet

  route {
    cidr_block             = var.cidr_block
    gateway_id             = var.gateway_id 
  }

  tags =  { 
    #Name = "Public-Route-Table" 
    Name = join(" ",["Public-Route-Table",each.key])
  }
}

# Route table associations - Public
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.public_subnet[each.key].id
  for_each       = var.public_subnet
  route_table_id = aws_route_table.main[each.key].id
}

resource "aws_eip" "gw" {
  count = "1"

  depends_on = [aws_internet_gateway.main]
}

resource "aws_nat_gateway" "gw" {
  count = "1"
  allocation_id = aws_eip.gw[0].id
  subnet_id =    aws_subnet.public_subnet[element(keys(aws_subnet.public_subnet), 0)].id

  depends_on = [aws_internet_gateway.main]
}


