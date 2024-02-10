variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_id" {
  description = "The VPC to be deployed"
  type        = string
  default     = "aws_vpc.main.id"
}

variable "vpc_cidr" {
  description = "The VPC Network Range"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "A list of public subnets inside the VPC"
  type        = map(string)
  default = {
    "ap-southeast-2a" : "10.0.10.0/24",
    "ap-southeast-2c" : "10.0.20.0/24"
  }
}

variable "private_subnet" {
  description = "A list of private subnets inside the VPC"
  type        = map(string)
  default = {
    "ap-southeast-2a" : "10.0.100.0/24",
    "ap-southeast-2c" : "10.0.200.0/24"
  }
}

variable "availability_zones" {
  description = "Availability Zones used"
  default     = ["ap-southeast-2a", "ap-southeast-2c"]
}

variable "cidr_block" {
  description = "CIDR Block to allow traffic via"
  type        = string
  default     = "0.0.0.0/0"
}

variable "route_table_id" {
  description = "The ID of the Routing Table"
  type        = string
  default     = "aws_route_table.main[each.key].id"
}

variable "gateway_id" {
  description = "Identifier of the VPC Internet Gateway"
  type        = string
  default     = "aws_internet_gateway.main.id"
}

variable "subnet_id" {
  description = "subnet ID which resources will be launched in"
  type        = string
  default     = "aws_subnet.public_subnet.id"
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

# VPC Single NAT Gateway (True or False)
variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = true
}