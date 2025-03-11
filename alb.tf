resource "aws_alb" "app-alb" {
    name        = "app-load-balancer"
    subnets         = aws_subnet.public.*.id
    security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "app-tg" {
    name        = "app-target-group"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = aws_vpc.app-vpc.id
    target_type = "ip"

    health_check {
        healthy_threshold   = "3"
        interval            = "30"
        protocol            = "HTTP"
        matcher             = "200"
        timeout             = "3"
        path                = var.health_check_path
        unhealthy_threshold = "2"
    }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.app-alb.id
  port              = 80 #replace it with var.app_port if you want to use same port for ALB which is being used in your container
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app-tg.id
    type             = "forward"
  }
}