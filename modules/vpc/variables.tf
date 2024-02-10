variable "vpc_cidr" {
  description = "The VPC Network Range"
  type = string
}

variable "vpc_id" {
  description = "The VPC to be deployed"
  type = string
}

variable "availability_zones" {
  description = "Avaiability Zones used"
  type = list(string)
}

variable "public_subnet" {
  description = "A list of public subnets inside the VPC"
  type = map(string)
}

variable "private_subnet" {
  description = "A list of private subnets inside the VPC"
  type = map(string)
}

variable "cidr_block" {
  description = "CIDR Block to allow traffic via"
  type = string
}

variable "route_table_id" {
  description = "The ID of the Routing Table"
  type = string
}

variable "gateway_id" {
  description = "Identifier of the VPC Internet Gateway"
  type = string
}

variable "subnet_id" {
  description =  "subnet ID which resources will be launched in"
  type = string
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
 
}

# VPC Single NAT Gateway (True or False)
variable "single_nat_gateway" {
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "public_subnet_names"{
  type = list
  default = ["public subnet1","public subnet2"]
}