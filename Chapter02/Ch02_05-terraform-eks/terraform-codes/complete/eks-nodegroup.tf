resource "aws_eks_node_group" "test-eks-nodegroup" {
  #cluster 지정
  cluster_name    = aws_eks_cluster.test-eks-cluster.name
  node_group_name = "test-eks-nodegroup"
  #eks cluster nodegroup arn 지정
  node_role_arn   = aws_iam_role.test-iam-role-eks-nodegroup.arn
  subnet_ids      = ["<Subnet ID 1>","<Subnet ID 2>"]
  instance_types = ["t3a.medium"]
  disk_size = 20

  labels = {
    "role" = "eks-nodegroup"
  }

  #Worker node
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  #선진행이 되야되는 부분 iam role policy
  depends_on = [
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup,
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup-cni,
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup-ecr,
  ]

  tags = {
    "Name" = "${aws_eks_cluster.test-eks-cluster.name}-worker-node"
  }
}
