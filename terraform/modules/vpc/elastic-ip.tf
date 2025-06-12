resource "aws_eip" "eip-1" {
  domain = "vpc"

  tags = {
    Name = "eip-1"
  }
}

resource "aws_eip" "eip-2" {
  domain = "vpc"

  tags = {
    Name = "eip-2"
  }
}