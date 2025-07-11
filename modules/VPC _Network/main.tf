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

#* Public Route Tables
resource "aws_route_table" "Public_RT" {
    vpc_id = aws_vpc.master_vpc.id
    route {
        cidr_block = var.RT_CIDRs[0]
        gateway_id = aws_internet_gateway.igw.id
    }

    route {
        cidr_block = var.RT_CIDRs[1]
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
    cidr_block              = var.priv_cidr_blocks[count.index]
    availability_zone       = var.azs[count.index]
    map_public_ip_on_launch = false

    tags = {
        Name = "PrivateSubnet${count.index + 1}"
    }
}

#* Creating 2 Elastic IP Addresses
resource "aws_eip" "ngw_eip" {
    count = 2
    domain = "vpc"
    tags = {
        Name = "NAT-EIP${count.index + 1}"
    }
}

#* Creating 2 NAT Gateways
resource "aws_nat_gateway" "NATGW" {
    count = 2
    allocation_id = aws_eip.ngw_eip[count.index].id
    subnet_id     = aws_subnet.public_subnet[count.index].id
    tags = {
        Name = "NATGW${count.index + 1}"
    }
}

#* Route Table for private subnet1
resource "aws_route_table" "Private_RT1" {
    depends_on = [aws_nat_gateway.NATGW]
    vpc_id = aws_vpc.master_vpc.id

    route {
        cidr_block = var.RT_CIDRs[0]
        gateway_id = aws_nat_gateway.NATGW[0].id
    }

    route {
        cidr_block = var.RT_CIDRs[1]
        gateway_id = "local"
    }

    tags = {
        Name      = "Private_RT_1"
    }
}

#* Associate private route table 1 to private subnet 1
resource "aws_route_table_association" "pri_sub1_rt" {
    depends_on     = [aws_subnet.private_subnet1]
    route_table_id = aws_route_table.Private_RT1.id
    subnet_id      = aws_subnet.private_subnet[0].id
}

#* Route Table for private subnet2
resource "aws_route_table" "Private_RT2" {
    depends_on = [aws_nat_gateway.NATGW]
    vpc_id = aws_vpc.master_vpc.id

    route {
        cidr_block = var.RT_CIDRs[0]
        gateway_id = aws_nat_gateway.NATGW[1].id
    }

    route {
        cidr_block = var.RT_CIDRs[1]
        gateway_id = "local"
    }

    tags = {
        Name      = "Private_RT_1"
    }
}

#* Associate private route table 2 to private subnet 2
resource "aws_route_table_association" "pri_sub1_rt" {
    depends_on     = [aws_subnet.private_subnet2]
    route_table_id = aws_route_table.Private_RT2.id
    subnet_id      = aws_subnet.private_subnet[1].id
}