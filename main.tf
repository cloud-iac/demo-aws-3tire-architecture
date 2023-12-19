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
  pjt_name       = var.pjt_name
  igw_id         = module.tree_tire_web_infra.vpc_resources.igw_id
  nat_gw_id      = module.tree_tire_web_infra.vpc_resources.nat_gw_id
  routing_tables = module.tree_tire_web_infra.vpc_resources.routing_tables
}
module "instance" {
  source            = "./instance"
  bestion_subnet_id = module.tree_tire_web_infra.vpc_resources.subnets["10.0.1.0/24"]
  bestion_sg_ids    = [module.tree_tire_web_infra.vpc_resources.security_groups["pub_bestion_sg"]]
  ssh-key           = var.ssh-key

  front_subnet_id = module.tree_tire_web_infra.vpc_resources.subnets["10.0.2.0/24"]
  front_sg_ids    = [module.tree_tire_web_infra.vpc_resources.security_groups["pri_front_sg"]]

  backend_subnet_id = module.tree_tire_web_infra.vpc_resources.subnets["10.0.3.0/24"]
  backend_sg_ids    = [module.tree_tire_web_infra.vpc_resources.security_groups["pri_back_sg"]]
}
module "lb_asg" {
  source = "./lb_asg"
  domain_name = var.domain_name
  vpc_id = module.tree_tire_web_infra.vpc_resources.vpc

  front_template_id = module.instance.front_template_id
  back_template_id  = module.instance.back_template_id

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
module "rds" {
  source = "./rds"
  db_name = var.db_name
  username = var.db_username
  password = var.db_password
  subnet_ids = [
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.4.0/24"],
    module.tree_tire_web_infra.vpc_resources.subnets["10.0.14.0/24"]
  ]
  db_sg_ids = [
    module.tree_tire_web_infra.vpc_resources.security_groups["pri_db_sg"]
  ]
}
module "route53" {
  source = "./route53"
  vpc_id = module.tree_tire_web_infra.vpc_resources.vpc
  inter_alb_dns = module.lb_asg.pri_alb_dns
  db_dns = module.rds.db_dns
  public_alb_dns = module.lb_asg.pub_alb_dns
  pri_alb_zone_id = module.lb_asg.pri_zone_id
  pub_alb_zone_id = module.lb_asg.pub_zone_id
}
output "info" {
  value = {
    infra = module.tree_tire_web_infra.vpc_resources
    bestion     = module.instance.bestion_ip
    front       = module.instance.front_template_id
    backend     = module.instance.back_template_id
    pub_alb_dns = module.lb_asg.pub_alb_dns
    pri_alb_dns = module.lb_asg.pri_alb_dns
    db_dns = module.rds.db_dns
  }
}