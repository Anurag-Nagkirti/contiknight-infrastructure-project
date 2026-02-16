
#Creating VPC...
resource "aws_vpc" "contiknight_vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "contiknight_vpc"
    } 
}


#Creating public subnet...
resource "aws_subnet" "public_subnet_contiknight" {
    vpc_id = aws_vpc.contiknight_vpc.id
    cidr_block = 
    map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet_contiknight"
    }
}


#Creating private subnet...
resource "aws_subnet" "private_subnet_contiknight" {
    vpc_id = aws_vpc.contiknight_vpc.id
    cidr_block = 
    map_public_ip_on_launch = true
    tags = {
        Name = "private_subnet_contiknight"
    }
}


#Creating internet gateway...
resource "aws_internet_gateway" "contiknight_ig" {
    vpc_id = aws_vpc.contiknight_vpc.id
    tags = {
        Name = "contiknight_ig"
    }
}

#Creating route table
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.contiknight_vpc.id
    route = {
        cidr_block = 0.0.0.0/0
        gateway_id = aws_internet_gateway.contiknight_ig.id
    }
}

#Creating route table
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.contiknight_vpc.id
}
