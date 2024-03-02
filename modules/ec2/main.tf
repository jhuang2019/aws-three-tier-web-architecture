# App - Launch Template
resource "aws_launch_template" "main" {
  name = "EC2-web-instance"
  description = "Template to launch an EC2 instance and deploy the application"
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.ec2_security_group]
  network_interfaces {
    device_index = 0
    #subnet_id = data.aws_subnet.subnet_mgmt.id
    subnet_id = var.public_subnet_2a_id
    associate_public_ip_address = true
  }  
  user_data              = filebase64("./modules/ec2/install.sh")

  tags = {
    Name = "EC2 web instance launch template"
  }
}

resource "aws_instance" "ec2_instance" {
  ami           = var.image_id
  instance_type = var.instance_type
  subnet_id                   = var.public_subnet_2a_id
  vpc_security_group_ids      = [var.ec2_security_group]
  associate_public_ip_address = true
  user_data              = filebase64("./modules/ec2/install.sh")

  tags = {
    Name = "EC2 web instance"
  }
}