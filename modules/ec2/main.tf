/*data "aws_ami" "amazon-linux2" {
 most_recent = true
 filter {
    name   = "architecture"
    values = ["x86_64"]
  }
 filter {
   name   = "name"
   values = ["Web server v1"]
 }
 owners = ["058264449946"] # AWS
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

/* create an ami from the EC2 intance created above */
resource  "aws_ami_from_instance" "from_ec2_ami" {
    name               = "Web server v1"
    description = "LAMP web server AMI"
    source_instance_id = aws_instance.ec2_instance.id

  depends_on = [
      aws_instance.ec2_instance,
      ]

  tags = {
      Name = "from-ec2-ami"
  }
}

/* create an application load balancer */

#Application Load Balancer
resource "aws_lb" "main" {
  name               = var.app_alb_name
  internal           = var.alb_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [var.web_alb_security_group_name]
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

/* configure launch template */
# App - Launch Template
resource "aws_launch_template" "main" {
  name = "EC2-web-instance"
  description = "Template to launch an EC2 instance and deploy the application"
  #image_id               = data.aws_ami.amazon-linux2.id
  image_id               = aws_ami_from_instance.from_ec2_ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.asg_web_inst_security_group]
  
  user_data              = filebase64("./modules/ec2/install.sh")

  tags = {
    Name = "EC2 web instance launch template"
  }
}

# Create auto scaling policy
resource "aws_autoscaling_policy" "example" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  name                   = "asg-autoscaling-policy"
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 30    
  }
  estimated_instance_warmup = 60
}

#Create Auto scaling group
resource "aws_autoscaling_group" "asg" {
  name = "Web-ASG"
  vpc_zone_identifier = [ var.private_subnet_2a_id, var.private_subnet_2c_id ]
  desired_capacity   = 2
  max_size           = 4
  min_size           = 2
  health_check_type = "ELB"
  health_check_grace_period = 120
  target_group_arns = [aws_lb_target_group.main.arn]
  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "ASG-Web-Inst"
    propagate_at_launch = true
  }
}
