#Creating VPC...
resource "aws_vpc" "contiknight_vpc" {
    cidr_block = var.vpc_cidr_block
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
        Name = "contiknight_vpc"
        Managed_By = "Terraform"
    }
}


#Creating public subnet...
resource "aws_subnet" "public_subnet_contiknight" {
    vpc_id = aws_vpc.contiknight_vpc.id
    cidr_block = var.public_subnet_cidr_block
    map_public_ip_on_launch = true
    tags = {
        Name = "public_subnet_contiknight"
        Managed_By = "Terraform"
    }
}


#Creating private subnet...
resource "aws_subnet" "private_subnet_contiknight" {
    vpc_id = aws_vpc.contiknight_vpc.id
    cidr_block = var.private_subnet_cidr_block
    map_public_ip_on_launch = true
    tags = {
        Name = "private_subnet_contiknight"
        Managed_By = "Terraform"
    }
}


#Creating internet gateway...
resource "aws_internet_gateway" "contiknight_ig" {
    vpc_id = aws_vpc.contiknight_vpc.id
    tags = {
        Name = "contiknight_ig"
        Managed_By = "Terraform"
    }
}

#Creating route table
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.contiknight_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.contiknight_ig.id
    }
}

#Associating public routable to public subnet
resource "aws_route_table_association" "rt_ass_public" {
    subnet_id = aws_subnet.public_subnet_contiknight.id
    route_table_id = aws_route_table.public.id
}


#Creating route table
resource "aws_route_table" "private" {
    vpc_id = aws_vpc.contiknight_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.contiknight_natgateway.id
    }
}

#Associating private routetable to private route table
resource "aws_route_table_association" "rt_ass_private" {
    subnet_id = aws_subnet.private_subnet_contiknight.id
    route_table_id = aws_route_table.private.id
}


##Creating EllasticIP for NAT Gateway

resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
      Name = "nat_eip"
      Managed_By = "Terraform"
    }

}

#Creating NAT gateway and associating Elastic IP to NAT gateway
resource "aws_nat_gateway" "contiknight_natgateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet_contiknight.id
}
