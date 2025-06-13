# Log Group in Cloud Watch
resource "aws_cloudwatch_log_group" "vpc_logs" {
  name = "/aws/vpc/flow-logs"
  retention_in_days = 14
  kms_key_id        = aws_kms_key.vpc_logs_key.arn
}

# Create flow logs
resource "aws_flow_log" "vpc_flow_log" {
  log_destination      = aws_cloudwatch_log_group.vpc_logs.arn
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.nti-project.id
  iam_role_arn         = aws_iam_role.flow_logs_role.arn
}


