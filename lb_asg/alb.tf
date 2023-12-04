resource "aws_lb" "pub-alb" {
  name               = "front-tier-alb"
  load_balancer_type = "application"
  security_groups    = var.pub_alb_sg_groups

  subnets = var.pub_alb_subnets

  tags = {
    Name = "pub-alb"
  }
}

resource "aws_lb" "pri-alb" {
  name               = "back-tier-alb"
  load_balancer_type = "application"
  security_groups    = var.pri_alb_sg_groups
  internal = true
  subnets = var.pri_alb_subnets

  tags = {
    Name = "pri-alb"
  }
}