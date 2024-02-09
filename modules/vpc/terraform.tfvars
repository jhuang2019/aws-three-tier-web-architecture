vpc_cidr = [
  "10.0.0.0/16"
]

vpc_id = [
  "aws_vpc.main.id"
]

availability_zones = [
  "ap-southeast-2a",
  "ap-southeast-2c"
]

public_subnet = {
  "ap-southeast-2a" : "10.0.10.0/24",
  "ap-southeast-2c" : "10.0.20.0/24" 
}

private_subnet = {
  "ap-southeast-2a" : "10.0.100.0/24",
  "ap-southeast-2c" : "10.0.200.0/24" 
}

cidr_block = [
  "0.0.0.0/0"
]

enable_dns_hostnames = true

enable_dns_support = true

single_nat_gateway = true