# App - Launch Template
/*resource "aws_launch_template" "main" {
  name = "EC2-web-instance"
  description = "Template to launch an EC2 instance and deploy the application"
  image_id               = var.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.ec2_security_group]
  network_interfaces {
    device_index = 0
    subnet_id = var.public_subnet_2a_id
    associate_public_ip_address = true
  }  
  user_data              = filebase64("./modules/ec2/install.sh")

  tags = {
    Name = "EC2 web instance launch template"
  }
}*/

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

resource  "aws_ami_from_instance" "from_ec2_ami" {
    name               = "Web server v1"
    description = "LAMP web server AMI"
    source_instance_id = "${aws_instance.ec2_instance.id}"

  depends_on = [
      aws_instance.ec2_instance,
      ]

  tags = {
      Name = "from-ec2-ami"
  }
}

#Application Load Balancer
resource "aws_lb" "main" {
  name               = var.app_alb_name
  internal           = var.alb_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.web_alb_security_group_name]
  #subnets            = [for value in aws_subnet.public_subnet : value.id] 
  subnets = [ var.public_subnet_2a_id, var.public_subnet_2c_id ] 

  tags = {
     Name = "Application-ALB" 
  }
}

#Application Load Balancer Listener
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.arn
  port              = var.alb_listener_port
  protocol          = var.alb_listener_protocol

  default_action {
    type             = var.alb_listener_type
    target_group_arn = aws_lb_target_group.main.arn
  }
}

#Application Load Balancer Target Group
resource "aws_lb_target_group" "main" {
  name     = var.alb_target_group
  port     = var.alb_target_group_port
  protocol = var.alb_target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    protocol  = var.alb_target_group_protocol
    port     = var.alb_target_group_port
  }
}