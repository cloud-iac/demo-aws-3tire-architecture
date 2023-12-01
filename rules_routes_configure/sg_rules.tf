locals {
  sg_groups = var.security_groups
}
//80,443 0.0.0.0/0 허용
resource "aws_security_group_rule" "ingress_alb_pub" {
  for_each          = var.ingress_alb_pub
  type              = each.value.type
  to_port           = each.key
  from_port         = each.key
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = local.sg_groups.pub_alb_sg
}
//22 0.0.0.0/0 허용
resource "aws_security_group_rule" "ingress_bestion" {
  for_each          = var.ingress_bestion
  type              = each.value.type
  to_port           = each.key
  from_port         = each.key
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = local.sg_groups.front_sg
}

//80,443,3000 퍼블릭 alb 보안 그룹만 허용, 22 베스천 그룹 허용
resource "aws_security_group_rule" "ingress_front" {
  for_each          = var.ingress_front
  type              = each.value.type
  to_port           = each.key
  from_port         = each.key
  protocol          = each.value.protocol
  source_security_group_id =  local.sg_groups.pub_alb_sg
  security_group_id = local.sg_groups.front_sg
}

//80,443 프론트 보안 그룹만 허용
resource "aws_security_group_rule" "ingress_alb_pri" {
  for_each          = var.ingress_alb_pri
  type              = each.value.type
  to_port           = each.key
  from_port         = each.key
  protocol          = each.value.protocol
  source_security_group_id =  local.sg_groups.front_sg
  security_group_id = local.sg_groups.pri_alb_sg
}
//80,443,8080 프라이 alb그룹만 허용
resource "aws_security_group_rule" "ingress_back" {
  for_each          = var.ingress_back
  type              = each.value.type
  to_port           = each.key
  from_port         = each.key
  protocol          = each.value.protocol
  source_security_group_id =  local.sg_groups.pri_alb_sg
  security_group_id = local.sg_groups.back_sg
}
//3306 백엔드 보안그룹만 허용
resource "aws_security_group_rule" "ingress_db" {
  for_each          = var.ingress_db
  type              = each.value.type
  to_port           = each.key
  from_port         = each.key
  protocol          = each.value.protocol
  source_security_group_id =  local.sg_groups.back_sg
  security_group_id = local.sg_groups.db_sg
}

//모든 보안그룹 아웃바운드 설정 
resource "aws_vpc_security_group_egress_rule" "egress" {
  for_each = local.sg_groups
  security_group_id = each.value
  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = "-1"
}