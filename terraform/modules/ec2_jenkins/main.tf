resource "aws_instance" "jenkins" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = var.security_group_ids
  iam_instance_profile        = aws_iam_instance_profile.jenkins_instance_profile.name
  associate_public_ip_address = var.associate_public_ip_address

  metadata_options {
  http_endpoint               = "enabled"
  http_tokens                 = "required"
  http_put_response_hop_limit = 1
  }


  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp2"
    delete_on_termination = true
    encrypted             = true
  }

  tags = merge(
    {
      Name        = "jenkins-server"
      Backup      = "true"
      Environment = "dev"
    },
    var.tags
  )
}
