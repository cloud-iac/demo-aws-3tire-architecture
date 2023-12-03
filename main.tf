module "tree_tire_web_infra" {
  source                 = "./tree_tire_web_infra"
  pjt_name               = var.pjt_name
  vpc_cidr_block         = var.vpc_cidr_block
  pub_alb_tire_subnets   = var.pub_alb_tire_subnets
  pri_front_tire_subents = var.pri_front_tire_subents
  pri_back_tire_subnets  = var.pri_back_tire_subnets
  pri_db_tire_subnets    = var.pri_db_tire_subnets
}
module "security_rules" {
  source          = "./security_rules"
  security_groups = module.tree_tire_web_infra.vpc_resources.security_groups
}
module "route" {
  source         = "./route"
  igw_id         = module.tree_tire_web_infra.vpc_resources.igw_id
  nat_gw_id      = module.tree_tire_web_infra.vpc_resources.nat_gw_id
  routing_tables = module.tree_tire_web_infra.vpc_resources.routing_tables
}
module "instances" {
  source            = "./instances"
  bestion_subnet_id = module.tree_tire_web_infra.vpc_resources.subnets["10.0.1.0/24"]
  bestion_sg_ids    = [module.tree_tire_web_infra.vpc_resources.security_groups["pub_bestion_sg"]]
  ssh-key-name      = var.ssh-key-name
  ssh-key-path      = var.ssh-key-path

  front_subnet_id = module.tree_tire_web_infra.vpc_resources.subnets["10.0.2.0/24"]
  front_sg_ids    = [module.tree_tire_web_infra.vpc_resources.security_groups["pri_front_sg"]]

  backend_subnet_id = module.tree_tire_web_infra.vpc_resources.subnets["10.0.3.0/24"]
  backend_sg_ids    = [module.tree_tire_web_infra.vpc_resources.security_groups["pri_back_sg"]]
}
module "lb_asg" {
  source = "./lb_asg"
  vpc_id = module.tree_tire_web_infra.vpc_resources.vpc

  front_template_id = module.instances.front_template_id
  back_template_id  = module.instances.back_template_id

  front_subnets = [
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.2.0/24"],
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.12.0/24"]
  ]
  pub_alb_subnets = [
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.1.0/24"],
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.11.0/24"]
  ]
  pub_alb_sg_groups = [
    module.tree_tire_web_infra.vpc_resources.security_groups["pub_alb_sg"]
  ]

  back_subnets = [
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.3.0/24"],
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.13.0/24"]
  ]
  pri_alb_subnets = [
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.3.0/24"],
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.13.0/24"]
  ]
  pri_alb_sg_groups = [
    module.tree_tire_web_infra.vpc_resources.security_groups["pri_alb_sg"]
  ]
}
output "created_vpc" {
  value = module.tree_tire_web_infra.vpc_resources
}
output "instance_ips" {
  value = {
    bestion = module.instances.bestion_ip
    front   = module.instances.front_template_id
    backend = module.instances.back_template_id
  }
}