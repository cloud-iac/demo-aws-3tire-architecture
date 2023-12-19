data "aws_acm_certificate" "lundaljung" {
  domain   = var.domain_name
  statuses = ["ISSUED"]
}
resource "aws_lb_target_group" "pub_alb_tg" {
  name     = "pub-alb-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "pub_alb_tg"
  }
}
resource "aws_lb_listener" "http_pub_alb_listner" {
  load_balancer_arn = aws_lb.pub-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
resource "aws_lb_listener" "https_pub_alb_listner" {
  load_balancer_arn = aws_lb.pub-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = data.aws_acm_certificate.lundaljung.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pub_alb_tg.arn
  }
}

resource "aws_lb_target_group" "pri_alb_tg" {
  name     = "pri-alb-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/healthz"
    port                = 80
    protocol            = "HTTP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }
  tags = {
    Name = "pri_alb_tg"
  }
}
resource "aws_lb_listener" "pri_alb_listner" {
  load_balancer_arn = aws_lb.pri-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pri_alb_tg.arn
  }
}