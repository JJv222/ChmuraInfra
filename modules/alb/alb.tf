resource "aws_lb" "alb" {
  name               =  "${var.project_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.alb_subnets

  tags = {
    Environment = "alb"
  }
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "${var.project_name}-frontend-alb-tg"
  port     = var.frontend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.frontend_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_lb_target_group" "backend_alb_tg" {
  name     = "${var.project_name}-backend-alb-tg"
  port     = var.backend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "backend" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.backend_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_alb_tg.arn
  }
}

