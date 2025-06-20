# tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group" "jenkins_sg" {
  name        = "${var.jenkins_name}-sg"
  description = "Security group for Jenkins EC2 instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH from specific IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip_for_jenkins]
  }

  ingress {
    description = "Allow Jenkins Web UI access"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip_for_jenkins]
  }
  
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "${var.jenkins_name}-sg"
  }, var.tags)
}
