module "tree_tire_web_infra" {
  source         = "./tree_tire_web_infra"
  pjt_name       = "aws_3_tire_web"
  region         = "ap-northeast-2"
  vpc_cidr_block = "10.0.0.0/16"
  pub_alb_tire_subnets = {
    pub_sn_01 = {
      cidr_block           = "10.0.1.0/24"
      availability_zone_id = "apne2-az1"
    },
    pub_sn_02 = {
      cidr_block           = "10.0.11.0/24"
      availability_zone_id = "apne2-az3"
    },
  }
  pri_front_tire_subents = {
    pri_sn_front_01 = {
      cidr_block           = "10.0.2.0/24"
      availability_zone_id = "apne2-az1"
    },
    pri_sn_front_02 = {
      cidr_block           = "10.0.12.0/24"
      availability_zone_id = "apne2-az3"
    },
  }
  pri_back_tire_subnets = {
    pri_sn_back_01 = {
      cidr_block           = "10.0.3.0/24"
      availability_zone_id = "apne2-az1"
    },
    pri_sn_back_02 = {
      cidr_block           = "10.0.13.0/24"
      availability_zone_id = "apne2-az3"
    },
  }
  pri_db_tire_subnets = {
    pri_sn_db_01 = {
      cidr_block           = "10.0.4.0/24"
      availability_zone_id = "apne2-az1"
    },
    pri_sn_db_02 = {
      cidr_block           = "10.0.14.0/24"
      availability_zone_id = "apne2-az3"
    },
  }
}

output "created_vpc" {
  value = module.tree_tire_web_infra.vpc_resources
}