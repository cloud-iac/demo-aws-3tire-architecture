resource "aws_autoscaling_group" "front_asg" {
  name                = "front_asg"
  vpc_zone_identifier = var.front_subnets

  target_group_arns = [aws_lb_target_group.pub_alb_tg.arn]
  health_check_type = "ELB"

  min_size                  = 1
  desired_capacity          = 1
  max_size                  = 2
  health_check_grace_period = 300
  force_delete              = true

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }
  launch_template {
    id      = var.front_template_id
    version = "$Latest"
  }
}

resource "aws_autoscaling_group" "back_asg" {
  name                = "back_asg"
  vpc_zone_identifier = var.back_subnets

  target_group_arns = [aws_lb_target_group.pri_alb_tg.arn]
  health_check_type = "ELB"

  min_size                  = 1
  desired_capacity          = 1
  max_size                  = 2
  health_check_grace_period = 300
  force_delete              = true

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  launch_template {
    id      = var.back_template_id
    version = "$Latest"
  }
}