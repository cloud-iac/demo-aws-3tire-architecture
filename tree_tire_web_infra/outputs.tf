output "vpc_resources" {
  value = {
    vpc = aws_vpc.vpc.id
    subnets = values(aws_subnet.subnets).*.cidr_block
    routing_tables = values(aws_route_table.routing_tables).*.id
    igw = aws_internet_gateway.igw.id
    nat = aws_nat_gateway.nat_gateway.public_ip
    nat_eip = aws_eip.nat_eip.public_ip
    betion_eip = aws_eip.betion_eip.public_ip
  }
}
