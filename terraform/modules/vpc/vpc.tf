resource "aws_vpc" "nti-project" {
  cidr_block       = var.vpc_cidr_block
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.vpc_name}"
  }
}