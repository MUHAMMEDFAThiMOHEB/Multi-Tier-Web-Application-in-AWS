module "vpc" {
    source           = "./modules/VPC _Network"
    vpc_cidr_block   = "10.0.0.0/16"
    pub_cidr_blocks  = ["10.0.10.0/24", "10.0.20.0/24"]
    priv_cidr_blocks = ["10.0.100.0/24", "10.0.200.0/24"]
    azs              = ["eu-central-1a", "eu-central-1b"]
    RT_CIDRs         = ["0.0.0.0/0", "10.0.0.0/16"]
}

module "SG" {
    source = "./modules/Security_Groups"
    vpc_id = module.vpc.vpc_id
    cidr_global = "0.0.0.0/0"
}