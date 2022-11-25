resource "aws_eks_cluster" "test-eks-cluster" {
  depends_on = [
    aws_iam_role_policy_attachment.test-iam-policy-eks-cluster,
    aws_iam_role_policy_attachment.test-iam-policy-eks-cluster-vpc,
  ]

  name = var.cluster-name
  role_arn = aws_iam_role.test-iam-role-eks-cluster.arn
  version = "1.21"

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    security_group_ids = [aws_security_group.test-sg-eks-cluster.id]
    subnet_ids = ["subnet-0e81f58c442fcb870", "subnet-0d390e6402fc78468"]
    endpoint_public_access = true
  }
}