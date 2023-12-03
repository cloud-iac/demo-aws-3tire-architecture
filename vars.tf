variable "ssh-key-name" {
  default = "aws_ec2-key"
}
variable "ssh-key-path" {
  default = "~/.ssh/aws_ec2.pem"
}
variable "pjt_name" {
  default = "aws_3_tire_web"
}
variable "region" {
  default = "ap-northeast-2"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "pub_alb_tire_subnets" {
  default = {
    pub_sn_01 = {
      cidr_block           = "10.0.1.0/24"
      availability_zone_id = "apne2-az1"
    },
    pub_sn_02 = {
      cidr_block           = "10.0.11.0/24"
      availability_zone_id = "apne2-az3"
    },
  }
}
variable "pri_front_tire_subents" {
  default = { pri_sn_front_01 = {
    cidr_block           = "10.0.2.0/24"
    availability_zone_id = "apne2-az1"
    },
    pri_sn_front_02 = {
      cidr_block           = "10.0.12.0/24"
      availability_zone_id = "apne2-az3"
  }, }
}
variable "pri_back_tire_subnets" {
  default = {
    pri_sn_back_01 = {
      cidr_block           = "10.0.3.0/24"
      availability_zone_id = "apne2-az1"
    },
    pri_sn_back_02 = {
      cidr_block           = "10.0.13.0/24"
      availability_zone_id = "apne2-az3"
    },
  }
}
variable "pri_db_tire_subnets" {
  default = {
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