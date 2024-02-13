# VPC
resource "aws_vpc" "infra_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
    Name = "infra-vpc"
    }
}

# IGW
resource "aws_internet_gateway" "infra_igw" {
    vpc_id = aws_vpc.infra_vpc.id
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
    count = length("${var.azs}")
    vpc_id = aws_vpc.infra_vpc.id
    cidr_block = "192.168.${2 * count.index + 2}.0/24"
    availability_zone = "${var.azs[count.index]}"
    tags = {
        Name = "public-${var.azs[count.index]}"
    }
}

# Private Subnet
resource "aws_subnet" "private_subnet" {
    count = length("${var.azs}")
    vpc_id = aws_vpc.infra_vpc.id
    cidr_block = "192.168.${2 * count.index + 1}.0/24"
    availability_zone = "${var.azs[count.index]}"
    tags = {
        Name = "private-${var.azs[count.index]}"
    }
}

