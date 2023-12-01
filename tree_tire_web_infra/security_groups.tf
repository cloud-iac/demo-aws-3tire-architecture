locals {
  security_groups = ["pub_alb_sg", "pri_alb_sg", "front_sg", "back_sg", "db_sg"]
}
resource "aws_security_group" "security_groups" {
  for_each    = toset(local.security_groups)
  name        = each.value
  description = each.value
  vpc_id      = aws_vpc.vpc.id
  tags = {
    Name = "${each.value}"
  }
}