variable "region" {
  type = string
  description = "Region of aws"
}
variable "eks_sub_1" {
  type = string
}

variable "eks_sub_2" {
  type = string
}

variable "sg_cidr" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "nodes_desired_size" {
  type = number
}

variable "nodes_max_size" {
  type = number
}

variable "nodes_min_size" {
  type = number
}