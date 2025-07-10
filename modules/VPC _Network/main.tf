#* VPC creation
resource "aws_vpc" "master_vpc" {
    cidr_block = var.vpc_cidr_block

    tags = {
        Name = "Main_VPC"
    }
}

#* IGW creation
resource "aws_internet_gateway" "igw" {
    tags = {
        Name = "Main_IGW"
    }
}

resource "aws_internet_gateway_attachment" "igw_att" {
    internet_gateway_id = aws_internet_gateway.igw.id
    vpc_id = aws_vpc.master_vpc.id
}

#* Subnet creation
resource "aws_subnet" "public" {
    count = length(var.cidr_blocks)

    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.cidr_blocks[count.index]
    availability_zone       = var.azs[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "PublicSubnet-${count.index + 1}"
    }
}

