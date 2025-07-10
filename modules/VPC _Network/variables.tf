#* variables of VPC
variable "vpc_cidr_block" {
    type = string
    description = "the VPC CIDR_Block)"
}

#* variables of Public_subnets
variable "cidr_blocks" {
    type        = list(string)
    description = "CIDR blocks of the public subnets"

    validation {
        condition     = cidr_blocks == ["10.0.10.0/24", "10.0.20.0/24"]
        error_message = "Only the following CIDRs are allowed: 10.0.10.0/24 and 10.0.20.0/24."
    }
}

variable "azs" {
    type        = list(string)
    description = "Availability Zones to use for subnets"

    validation {
        condition     = azs == ["eu-central-1a", "eu-central-1b"]
        error_message = "Only eu-central-1a and eu-central-1b are allowed as AZs."
    }
}

