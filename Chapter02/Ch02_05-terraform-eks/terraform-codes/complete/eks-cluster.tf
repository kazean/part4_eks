resource "aws_eks_cluster" "test-eks-cluster" {
  #Policy 생성하는 순서
  depends_on = [
    aws_iam_role_policy_attachment.test-iam-policy-eks-cluster,
    aws_iam_role_policy_attachment.test-iam-policy-eks-cluster-vpc,
  ]

  name     = var.cluster-name
  #Role을 참조하여 eks cluster 생성
  role_arn = aws_iam_role.test-iam-role-eks-cluster.arn
  version = "1.21"

  #Control Plan logs
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  #vpc에 대한 정보
  vpc_config {
    #Security Group Terraform resource로 지정하여 Id지정
    security_group_ids = [aws_security_group.test-sg-eks-cluster.id]
    #AWS console subnet Id
    subnet_ids         = ["<Subnet ID 1>","<Subnet ID 2>"]
    #Internet 망에서 public access 허용
    endpoint_public_access = true
  }


}