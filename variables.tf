#* Provider Block Varibles
variable "region" {
    type = string
    description = "The used region in the solution"
}

variable "profile" {
    type = string
    description = "The used AWS profile"
    sensitive = true
}

