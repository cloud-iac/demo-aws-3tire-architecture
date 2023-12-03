locals {
  pub_alb_tire_subnets = var.pub_alb_tire_subnets == null ? {
    pub_sn_01 = {
      cidr_block           = "10.0.1.0/24"
      availability_zone_id = "apne2-az1"
    },
    pub_sn_02 = {
      cidr_block           = "10.0.11.0/24"
      availability_zone_id = "apne2-az3"
    },
  } : var.pub_alb_tire_subnets

  pri_front_tire_subents = var.pri_front_tire_subents == null ? {
    pri_sn_front_01 = {
      cidr_block           = "10.0.2.0/24"
      availability_zone_id = "apne2-az1"
    },
    pri_sn_front_02 = {
      cidr_block           = "10.0.12.0/24"
      availability_zone_id = "apne2-az3"
    },
  } : var.pri_front_tire_subents
  pri_back_tire_subnets = var.pri_back_tire_subnets == null ? {
    pri_sn_back_01 = {
      cidr_block           = "10.0.3.0/24"
      availability_zone_id = "apne2-az1"
    },
    pri_sn_back_02 = {
      cidr_block           = "10.0.13.0/24"
      availability_zone_id = "apne2-az3"
    },
  } : var.pri_back_tire_subnets
  pri_db_tire_subnets = var.pri_db_tire_subnets == null ? {
    pri_sn_db_01 = {
      cidr_block           = "10.0.4.0/24"
      availability_zone_id = "apne2-az1"
    },
    pri_sn_db_02 = {
      cidr_block           = "10.0.14.0/24"
      availability_zone_id = "apne2-az3"
    },
  } : var.pri_db_tire_subnets
}
resource "aws_subnet" "subnets" {
  for_each             = merge(local.pub_alb_tire_subnets, local.pri_front_tire_subents, local.pri_back_tire_subnets, local.pri_db_tire_subnets)
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = each.value.cidr_block
  availability_zone_id = each.value.availability_zone_id

  tags = {
    Name = "${var.pjt_name}_${each.key}"
  }
}