//image_id = "ami-07e1aeb90edb268a3"
image_id = "ami-023eb5c021738c6d0"

instance_type = "t2.micro"

app_alb = "Web-ALB"

alb_internal = "false"

load_balancer_type = "application"

alb_listener_port = "80"

alb_listener_protocol = "HTTP"

alb_listener_type = "forward"

alb_target_group = "web-TG"

alb_target_group_port = "80"

alb_target_group_protocol = "HTTP"

