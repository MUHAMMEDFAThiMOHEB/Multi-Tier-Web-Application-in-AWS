resource "aws_vpc" "master_vpc" {
    cidr_block = var.vpc_cidr_block
}

data "aws_availability_zones" "available_zones" {
}