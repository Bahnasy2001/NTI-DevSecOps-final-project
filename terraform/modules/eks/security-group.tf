resource "aws_security_group" "eks_sg" {
  name        = "EKS-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow ALB to reach app on port 3001"
    from_port = 3001
    to_port = 3001
    protocol = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }
  # Allow secure egress (HTTPS)
  egress {
    description      = "Allow outbound HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.sg_cidr]
  }

  # Optional: Allow DNS resolution
  egress {
    description      = "Allow outbound DNS"
    from_port        = 53
    to_port          = 53
    protocol         = "udp"
    cidr_blocks      = [var.sg_cidr]
  }
  egress {
  description      = "Allow to DocumentDB"
  from_port        = 27017
  to_port          = 27017
  protocol         = "tcp"
  cidr_blocks      = [aws_security_group.docdb_sg.id]
  }

  tags = {
    Name = "EKS-sg"
  }
}
