variable "region" {
  type = string
  description = "Region of aws"
}

variable vpc_name {
    type = string
    description = "Name of VPC"
}
variable "vpc_cidr_block" {
    type        = string
    description = "vpc CIDR block"
}
variable "pub_sub-1_cidr_block" {
    type = string
    description = "public subnet 1 CIDR"
}
variable "pub_sub-2_cidr_block" {
    type = string
    description = "public subnet 2 CIDR"
}

variable "priv_sub-1_cidr_block" {
  type = string
  description = "private subnet 1 CIDR"
}

variable "priv_sub-2_cidr_block" {
  type = string
  description = "private subnet 2 CIDR"
}