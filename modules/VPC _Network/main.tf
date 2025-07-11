#* VPC creation
resource "aws_vpc" "master_vpc" {
    cidr_block = var.vpc_cidr_block

    tags = {
        Name = "Main_VPC"
    }
}

#* IGW creation & attachment
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.master_vpc.id

    tags = {
        Name = "Main_IGW"
    }
}

#* Public Subnet creation
resource "aws_subnet" "public_subnet" {
    count = length(var.pub.cidr_blocks)

    vpc_id                  = aws_vpc.master_vpc.id
    cidr_block              = var.pub.cidr_blocks[count.index]
    availability_zone       = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "PublicSubnet-${count.index + 1}"
    }
}

#* Route Tables
resource "aws_route_table" "Public_RT" {
    vpc_id = aws_vpc.master_vpc.id
    route {
        cidr_block = var.public_RT_CIDRs[0]
        gateway_id = aws_internet_gateway.igw.id
    }

    route {
        cidr_block = var.public_RT_CIDRs[1]
        gateway_id = "local"
    }

    tags = {
        Name      = "Public_RT"
    }
}

#* Associate public route table with all public subnets
resource "aws_route_table_association" "public_subnet" {
    count = length(aws_subnet.public_subnet)
    route_table_id = aws_route_table.Public_RT.id
    subnet_id      = aws_subnet.public_subnet[count.index].id
    }

#* Create 2 Private subnets
resource "aws_subnet" "private_subnet" {
    count = length(var.priv_cidr_blocks)

    vpc_id                  = aws_vpc.master_vpc.id
    cidr_block              = var.priv.cidr_blocks[count.index]
    availability_zone       = var.azs[count.index]
    map_public_ip_on_launch = false

    tags = {
        Name = "PublicSubnet-${count.index + 1}"
    }
}