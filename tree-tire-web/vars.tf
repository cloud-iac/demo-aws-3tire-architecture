variable "pjt_name" { default = "aws-3-tire-web" }
variable "region" {}
variable "cidr_block" {}

variable "subnets" {
  default = [
    {
      name                 = "pub-sn-01"
      cidr_block           = "10.0.1.0/24"
      availability_zone_id = "apne2-az1"
    },
    {
      name                 = "pub-sn-02"
      cidr_block           = "10.0.11.0/24"
      availability_zone_id = "apne2-az3"
    },
    {
      name                 = "pri-sn-front-01"
      cidr_block           = "10.0.2.0/24"
      availability_zone_id = "apne2-az1"
    },
    {
      name                 = "pri-sn-front-02"
      cidr_block           = "10.0.12.0/24"
      availability_zone_id = "apne2-az3"
    },
    {
      name                 = "pri-sn-back-01"
      cidr_block           = "10.0.3.0/24"
      availability_zone_id = "apne2-az1"
    },
    {
      name                 = "pri-sn-back-02"
      cidr_block           = "10.0.13.0/24"
      availability_zone_id = "apne2-az3"
    },
    {
      name                 = "pri-sn-db-01"
      cidr_block           = "10.0.4.0/24"
      availability_zone_id = "apne2-az1"
    },
    {
      name                 = "pri-sn-db-02"
      cidr_block           = "10.0.14.0/24"
      availability_zone_id = "apne2-az3"
    },
  ]
}
