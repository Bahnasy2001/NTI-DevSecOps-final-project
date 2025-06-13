# A private encryption key will be used to secure the CloudWatch log group.
resource "aws_kms_key" "vpc_logs_key" {
  description             = "KMS key for encrypting VPC flow logs"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}