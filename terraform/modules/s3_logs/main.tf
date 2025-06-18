resource "aws_s3_bucket" "elb_logs" {
  bucket = var.bucket_name
  force_destroy = true
  
  tags = {
    Name = var.bucket_name
  }
}

resource "aws_s3_bucket_public_access_block" "elb_logs" {
  bucket = aws_s3_bucket.elb_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "elb_logs" {
  bucket = aws_s3_bucket.elb_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "elb_logs_lifecycle" {
  bucket = aws_s3_bucket.elb_logs.id

  rule {
    id     = "log-cleanup"
    status = "Enabled"

    expiration {
      days = 90
    }
  }
}

resource "aws_kms_key" "elb_logs" {
  description             = "KMS key for ELB logs bucket"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "elb_logs" {
  bucket = aws_s3_bucket.elb_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.elb_logs.arn
    }
  }
}


data "aws_iam_policy_document" "elb_logging" {
  statement {
    sid    = "AllowELBLogging"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logdelivery.elb.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = [
      "${aws_s3_bucket.elb_logs.arn}/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}


resource "aws_s3_bucket_policy" "elb_logging_policy" {
  bucket = aws_s3_bucket.elb_logs.id

  policy = data.aws_iam_policy_document.elb_logging.json
}

# tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "elb_logs_access" {
  bucket = "${var.bucket_name}-access"
}

resource "aws_s3_bucket_logging" "elb_logs" {
  bucket = aws_s3_bucket.elb_logs.id

  target_bucket = aws_s3_bucket.elb_logs_access.id
  target_prefix = "access-logs/"
}

resource "aws_s3_bucket_public_access_block" "elb_logs_access" {
  bucket = aws_s3_bucket.elb_logs_access.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "elb_logs_access" {
  bucket = aws_s3_bucket.elb_logs_access.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "elb_logs_access" {
  description             = "KMS key for ELB logs access bucket"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "elb_logs_access" {
  bucket = aws_s3_bucket.elb_logs_access.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.elb_logs_access.arn
    }
  }
}
