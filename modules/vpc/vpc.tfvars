vpc_cidr = ["10.0.0.0/16"]

vpc_id = ["aws_vpc.main.id"]

availability_zones = ["ap-southeast-2a", "ap-southeast-2c"]

public_subnet = ["10.0.10.0/24", "10.0.20.0/24"]

private_subnet = ["10.0.100.0/24", "10.0.200.0/24"]

cidr_block = ["0.0.0.0/0"]

gateway_id = ["aws_internet_gateway.main.id"]

enable_dns_hostnames = true

enable_dns_support = true

ec2_security_group_name = "ec2-instance-security-group"

web_alb_security_group_name = "web-ALB-SG"

asg_web_inst_security_group_name = "ASG-Web-Inst-SG"