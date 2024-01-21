# VPC
resource "aws_vpc" "demo_vpc" {
    cidr_block = "${var.vpc_ipv4_cidr}"
    enable_dns_hostnames = true
}

# Internet Gateway
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id
}

# NACL
resource "aws_network_acl" "demo_nacl" {
  vpc_id = aws_vpc.demo_vpc.id
  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
}

# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.demo_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }
}

# Public Subnet 2a
resource "aws_subnet" "public_subnet_2a" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "${var.public_subnet_2a_ipv4_cidr}"
    availability_zone = "ap-northeast-2a"
}

# Public Subnet 2c
resource "aws_subnet" "public_subnet_2c" {
    vpc_id = aws_vpc.demo_vpc.id
    cidr_block = "${var.public_subnet_2c_ipv4_cidr}"
    availability_zone = "ap-northeast-2c"
}

# Public Route Table Association 2a
resource "aws_route_table_association" "public_route_table_associ_2a" {
  subnet_id = aws_subnet.public_subnet_2a.id
  route_table_id = aws_route_table.public_route_table.id
}

# Public Route Table Association 2c
resource "aws_route_table_association" "public_route_table_associ_2c" {
  subnet_id = aws_subnet.public_subnet_2c.id
  route_table_id = aws_route_table.public_route_table.id
}