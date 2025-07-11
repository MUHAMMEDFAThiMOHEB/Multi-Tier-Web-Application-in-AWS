#* variables of VPC
variable "vpc_cidr_block" {
    type = string
    description = "the VPC CIDR_Block)"
}

#* variables of Public_subnets
variable "pub_cidr_blocks" {
    type        = list(string)
    description = "CIDR blocks of the public subnets"

    validation {
        condition     = var.cidr_blocks == ["10.0.10.0/24", "10.0.20.0/24"]
        error_message = "Only the following CIDRs are allowed: 10.0.10.0/24 and 10.0.20.0/24."
    }
}

#* variables of Private_subnets
variable "priv_cidr_blocks" {
    type        = list(string)
    description = "CIDR blocks of the private subnets"

    validation {
        condition     = var.cidr_blocks == ["10.0.100.0/24", "10.0.200.0/24"]
        error_message = "Only the following CIDRs are allowed: 10.0.100.0/24 and 10.0.200.0/24."
    }
}

#* Used AZs
variable "azs" {
    type        = list(string)
    description = "Availability Zones to use for subnets"

    validation {
        condition     = var.azs == ["eu-central-1a", "eu-central-1b"]
        error_message = "Only eu-central-1a and eu-central-1b are allowed as AZs."
    }
}

#* variables of Route Table
variable "public_RT_CIDRs" {
    type = list(string)
    description = "CIDR Blocsk Destinations"

    validation {
        condition     = var.cidr_blocks == ["0.0.0.0/0", "10.0.0.0/16"]
        error_message = "Only the following CIDRs are allowed: 0.0.0.0/0 and 10.0.0.0/16."
    }
}

