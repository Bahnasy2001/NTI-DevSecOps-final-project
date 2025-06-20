resource "aws_iam_role" "jenkins_ec2_role" {
  name = "${var.jenkins_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = merge({
    Name = "${var.jenkins_name}-role"
  }, var.tags)
}

resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name = "${var.jenkins_name}-instance-profile"
  role = aws_iam_role.jenkins_ec2_role.name
}

resource "aws_iam_role_policy_attachment" "ecr_access" {
  count      = var.enable_ecr_access ? 1 : 0
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_access" {
  count      = var.enable_cloudwatch_access ? 1 : 0
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "backup_access" {
  count      = var.enable_backup_access ? 1 : 0
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}
