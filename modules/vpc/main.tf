################################################################################
# VPC
################################################################################
resource "aws_vpc" "main" {
  #name = "VPC-Lab"
  cidr_block = var.vpc_cidr
  enable_dns_hostnames                 = var.enable_dns_hostnames
  enable_dns_support                   = var.enable_dns_support
}

# Public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id = var.vpc_id
  for_each = var.public_subnet
  availability_zone = each.key
  cidr_block = each.value
}

#Private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = var.vpc_id
  for_each          = var.private_subnet
  availability_zone = each.key
  cidr_block        = each.value
}


resource "aws_eip" "gw" {
  count = "1"
}

resource "aws_nat_gateway" "gw" {
  count = "1"
  allocation_id = aws_eip.gw[0].id
  #subnet_id = "${element(module.vpc.public_subnets,count.index)}"
  #subnet_id     = aws_subnet.public_subnet[0].id
   
  # subnet_id     = "${aws_subnet.public_subnet[0].id}"
  
  subnet_id =    aws_subnet.public_subnet[element(keys(aws_subnet.public_subnet), 0)].id
}


