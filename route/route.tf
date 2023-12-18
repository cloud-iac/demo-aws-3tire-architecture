locals {
  pjt_name       = var.pjt_name
  routing_tables = var.routing_tables
  nat_gw_id      = var.nat_gw_id
  igw_id         = var.igw_id
}
resource "aws_route" "pub_rt" {
  route_table_id         = local.routing_tables["${var.pjt_name}_pub_rt"]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = local.igw_id
}
resource "aws_route" "pri_front_rt" {
  route_table_id         = local.routing_tables["${var.pjt_name}_pri_front_rt"]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = local.nat_gw_id
}
resource "aws_route" "pri_back_rt" {
  route_table_id         = local.routing_tables["${var.pjt_name}_pri_back_rt"]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = local.nat_gw_id
}

