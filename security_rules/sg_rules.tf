locals {
  sg_groups = var.security_groups
}
//80,443 0.0.0.0/0 허용
resource "aws_security_group_rule" "ingress_alb_pub" {
  for_each = {
    80  = ["0.0.0.0/0"]
    443 = ["0.0.0.0/0"]
    3000 = ["0.0.0.0/0"]
  }
  type              = "ingress"
  to_port           = each.key
  from_port         = each.key
  protocol          = "tcp"
  cidr_blocks       = each.value
  security_group_id = local.sg_groups.pub_alb_sg
}
//22 0.0.0.0/0 허용
resource "aws_security_group_rule" "ingress_bestion" {
  for_each = {
    22 = ["0.0.0.0/0"]
  }
  type              = "ingress"
  to_port           = each.key
  from_port         = each.key
  protocol          = "tcp"
  cidr_blocks       = each.value
  security_group_id = local.sg_groups.pub_bestion_sg
}

//80,443,8080 퍼블릭 alb 보안 그룹만 허용, 22 베스천 그룹 허용
resource "aws_security_group_rule" "ingress_front" {
  for_each = {
    80   = "pub_alb_sg"
    443  = "pub_alb_sg"
    8080 = "pri_alb_sg"
    22   = "pub_bestion_sg"
    3000 = "pub_alb_sg"
  }
  type                     = "ingress"
  to_port                  = each.key
  from_port                = each.key
  protocol                 = "tcp"
  source_security_group_id = local.sg_groups["${each.value}"]
  security_group_id        = local.sg_groups.pri_front_sg
}

//80,443 프론트 보안 그룹만 허용
resource "aws_security_group_rule" "ingress_alb_pri" {
  for_each = {
    80  = "pri_front_sg"
    443 = "pri_front_sg"
    8080 = "pri_front_sg"
  }
  type                     = "ingress"
  to_port                  = each.key
  from_port                = each.key
  protocol                 = "tcp"
  source_security_group_id = local.sg_groups["${each.value}"]
  security_group_id        = local.sg_groups.pri_alb_sg
}
//80,443,8080 프라이 alb그룹만 허용 22 베스천 그룹 허용
resource "aws_security_group_rule" "ingress_back" {
  for_each = {
    80   = "pri_alb_sg"
    443  = "pri_alb_sg"
    8080 = "pri_alb_sg"
    22   = "pub_bestion_sg"
  }
  type                     = "ingress"
  to_port                  = each.key
  from_port                = each.key
  protocol                 = "tcp"
  source_security_group_id = local.sg_groups["${each.value}"]
  security_group_id        = local.sg_groups.pri_back_sg
}
//3306 백엔드 보안그룹만 허용
resource "aws_security_group_rule" "ingress_db" {
  for_each = {
    3306 = "pri_back_sg"
  }
  type                     = "ingress"
  to_port                  = each.key
  from_port                = each.key
  protocol                 = "tcp"
  source_security_group_id = local.sg_groups["${each.value}"]
  security_group_id        = local.sg_groups.pri_db_sg
}

//모든 보안그룹 아웃바운드 설정 
resource "aws_vpc_security_group_egress_rule" "egress" {
  for_each          = local.sg_groups
  security_group_id = each.value
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}