//vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block != null ? var.vpc_cidr_block : "10.0.0.0/16"
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

#nat-eip
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat_eip"
  }
}

#bastion-eip
resource "aws_eip" "betion_eip" {
  domain = "vpc"
  tags = {
    Name = "betion_eip"
  }
}

#nat-gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnets["pub_sn_01"].id

  tags = {
    Name = "${var.pjt_name}_nat_gateway"
  }
}