# ============================
# OIDC + IAM Role Setup
# ============================

# IAM OIDC Provider for EKS
resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.aws_eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.aws_eks.identity[0].oidc[0].issuer
}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.aws_eks.identity[0].oidc[0].issuer
  
  depends_on = [aws_eks_cluster.aws_eks]
}

# IAM Policy for AWS Load Balancer Controller
resource "aws_iam_policy" "alb_controller_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  path        = "/"
  description = "Policy for the AWS Load Balancer Controller"
  policy = file("${path.module}/../../iam_policies/aws_load_balancer_controller_policy.json")
}

# IAM Role Assume Policy
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
    }
  }
}

# IAM Role for AWS Load Balancer Controller
resource "aws_iam_role" "alb_controller_role" {
  name               = "AmazonEKSLoadBalancerControllerRole"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attach the IAM Policy to the Role
resource "aws_iam_role_policy_attachment" "alb_controller_attachment" {
  policy_arn = aws_iam_policy.alb_controller_policy.arn
  role       = aws_iam_role.alb_controller_role.name
}

# ============================
# Kubernetes Service Account
# ============================

resource "kubernetes_service_account" "alb_sa" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.alb_controller_role.arn
    }
  }
}


# metadata:
#   annotations:
#     alb.ingress.kubernetes.io/load-balancer-attributes: access_logs.s3.enabled=true,access_logs.s3.bucket=eks-alb-logs-hassan-XXXX

