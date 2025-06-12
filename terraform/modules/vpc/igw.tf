resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.nti-project.id

  tags = {
    Name = "nti-igw"
  }
}