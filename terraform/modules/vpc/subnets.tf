resource "aws_subnet" "public-sub-zone-1" {
  vpc_id     = aws_vpc.nti-project.id
  cidr_block = var.pub_sub-1_cidr_block
  availability_zone = "${var.region}a"
  tags = {
    Name = "public-sub-zone-1"
  }
}

resource "aws_subnet" "public-sub-zone-2" {
  vpc_id     = aws_vpc.nti-project.id
  cidr_block = var.pub_sub-2_cidr_block
  availability_zone = "${var.region}b"
  tags = {
    Name = "public-sub-zone-2"
  }
}

resource "aws_subnet" "private-sub-zone-1" {
  vpc_id            = aws_vpc.nti-project.id
  cidr_block        = var.priv_sub-1_cidr_block
  # "10.0.3.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "private-sub-zone-1"
  }
}

resource "aws_subnet" "private-sub-zone-2" {
  vpc_id            = aws_vpc.nti-project.id
  cidr_block        = var.priv_sub-2_cidr_block
  # "10.0.4.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "private-sub-zone-2"
  }
}