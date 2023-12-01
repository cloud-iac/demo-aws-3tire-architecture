output "vpc_resources" {
  value = {
    vpc = aws_vpc.vpc.id
    subnets = values(aws_subnet.subnets).*.cidr_block
    igw_id = aws_internet_gateway.igw.id
    nat_gw_id = aws_nat_gateway.nat_gateway.id
    nat_eip = aws_eip.nat_eip.public_ip
    betion_eip = aws_eip.betion_eip.public_ip
    security_groups = {
      for obj in values(aws_security_group.security_groups): obj.tags.Name => obj.id
    }
    routing_tables = {
      for obj in values(aws_route_table.routing_tables): obj.tags.Name => obj.id
    }

  }
}
