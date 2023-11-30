//vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block != null ? var.cidr_block : "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.pjt_name}_vpc"
  }
}

//internet-gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.pjt_name}_igw"
  }
}

//subnets => 2 publics 6 privates
resource "aws_subnet" "subnets" {
  for_each = {
    for subnet in var.subnets : subnet.name => subnet
  }
  vpc_id               = aws_vpc.vpc.id
  cidr_block           = each.value.cidr_block
  availability_zone_id = each.value.availability_zone_id

  tags = {
    Name = "${var.pjt_name}_${each.value.name}"
  }
}

//routing tables
