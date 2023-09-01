resource "aws_lb" "tf_alb" {
  name               = "apprds-lb-tf"
  internal           = false
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.public_subnet.id, aws_subnet.public_subnet_b.id]  # IDs das sub-redes

  tags = {
    Name = "app-db-alb"
  }
}

#Cria o target group do ALB
resource "aws_lb_target_group" "alb_target" {
  name     = "target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.az_vpc.id 

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

#Associa uma instancia a um target group do ALB
resource "aws_lb_target_group_attachment" "intance_attachment" {
  target_group_arn = aws_lb_target_group.alb_target.arn
  target_id        = aws_instance.terraform.id
  port             = 80
}


#Cria o listener group do ALB
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.tf_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_target.arn
    type             = "forward"
  }
}

output "elb_dns_name" {
  value = aws_lb.tf_alb.dns_name
}
