resource "aws_lb_target_group" "pub_alb_tg" {
  name     = "pub-alb-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags = {
    Name = "pub_alb_tg"
  }
}
resource "aws_lb_listener" "pub_alb_listner" {
  load_balancer_arn = aws_lb.pub-alb.arn
  port              = "80"
  protocol          = "HTTP"
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