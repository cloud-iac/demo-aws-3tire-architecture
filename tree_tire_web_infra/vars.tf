variable "pjt_name" { type = string }
variable "vpc_cidr_block" { type = string }
variable "pub_alb_tire_subnets" { type = map(map(string)) }
variable "pri_front_tire_subents" { type = map(map(string)) }
variable "pri_back_tire_subnets" { type = map(map(string)) }
variable "pri_db_tire_subnets" { type = map(map(string)) }