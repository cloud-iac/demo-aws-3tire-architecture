module "tree_tire_web_infra" {
  source                 = "./tree_tire_web_infra"
  pjt_name               = var.pjt_name
  region                 = var.region
  vpc_cidr_block         = var.vpc_cidr_block
  pub_alb_tire_subnets   = var.pub_alb_tire_subnets
  pri_front_tire_subents = var.pri_front_tire_subents
  pri_back_tire_subnets  = var.pri_back_tire_subnets
  pri_db_tire_subnets    = var.pri_db_tire_subnets
}
module "rules_routes_configure" {
  source          = "./rules_routes_configure"
  igw_id          = module.tree_tire_web_infra.vpc_resources.igw_id
  nat_gw_id       = module.tree_tire_web_infra.vpc_resources.nat_gw_id
  security_groups = module.tree_tire_web_infra.vpc_resources.security_groups
  routing_tables  = module.tree_tire_web_infra.vpc_resources.routing_tables
}
output "created_vpc" {
  value = module.tree_tire_web_infra.vpc_resources
}