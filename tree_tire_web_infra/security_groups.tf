locals {
  security_groups = ["pub_alb_sg", "pub_bestion_sg", "pri_alb_sg", "pri_front_sg", "pri_back_sg", "pri_db_sg"]
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