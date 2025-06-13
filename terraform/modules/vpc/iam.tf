# IAM Role for flow logs
resource "aws_iam_role" "flow_logs_role" {
  name = "vpc-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "flow_logs_policy" {
  role       = aws_iam_role.flow_logs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonVPCFlowLogsRole"
}