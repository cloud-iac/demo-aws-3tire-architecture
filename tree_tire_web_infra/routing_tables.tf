locals {
  routing_tables = ["pub_rt", "pri_front_rt", "pri_back_rt", "pri_db_rt"]
}
resource "aws_route_table" "routing_tables" {
  for_each = toset(local.routing_tables)
  vpc_id   = aws_vpc.vpc.id
  tags = {
    Name = "${var.pjt_name}_${each.value}"
  }
}
resource "aws_route_table_association" "pub_rt_ass" {
  for_each       = toset(["pub_sn_01", "pub_sn_02"])
  subnet_id      = aws_subnet.subnets["${each.value}"].id
  route_table_id = aws_route_table.routing_tables["pub_rt"].id
}
resource "aws_route_table_association" "pri_front_rt_ass" {
  for_each       = toset(["pri_sn_front_01", "pri_sn_front_02"])
  subnet_id      = aws_subnet.subnets["${each.value}"].id
  route_table_id = aws_route_table.routing_tables["pri_front_rt"].id
}
resource "aws_route_table_association" "pri_back_rt_ass" {
  for_each       = toset(["pri_sn_back_01", "pri_sn_back_02"])
  subnet_id      = aws_subnet.subnets["${each.value}"].id
  route_table_id = aws_route_table.routing_tables["pri_back_rt"].id
}
resource "aws_route_table_association" "pri_db_rt_ass" {
  for_each       = toset(["pri_sn_db_01", "pri_sn_db_02"])
  subnet_id      = aws_subnet.subnets["${each.value}"].id
  route_table_id = aws_route_table.routing_tables["pri_db_rt"].id
}