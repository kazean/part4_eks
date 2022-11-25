resource "aws_eks_node_group" "test-eks-nodegroup" {
  cluster_name = aws_eks_cluster.test-eks-cluster.name
  node_group_name = "test-eks-nodegroup"
  node_role_arn = aws_iam_role.test-iam-role-eks-nodegroup.arn
  subnet_ids = ["subnet-0e81f58c442fcb870", "subnet-0d390e6402fc78468"]
  instance_types = ["t3a.medium"]
  disk_size = 20

  labels = {
    "role" = "eks-nodegroup"
  }

  scaling_config {
    desired_size = 1
    min_size = 1
    max_size = 1
  }
  
  depends_on = [
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup,
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup-cni,
    aws_iam_role_policy_attachment.test-iam-policy-eks-nodegroup-ecr
  ]

  tags = {
    "Name" = "${aws_eks_cluster.test-eks-cluster.name}-worker-node"
  }
}

resource "aws_eks_node_group" "test-eks-nodegroup2" {
  cluster_name = aws_eks_cluster.test-eks-cluster.name
  node_group_name = "test-eks-nodegroup2"
  node_role_arn = aws_iam_role.test-iam-role-eks-nodegroup.arn
  subnet_ids = ["subnet-0e81f58c442fcb870", "subnet-0d390e6402fc78468"]
  # instance_types = ["t3a.medium"]
  # disk_size = 20

  labels = {
    "role" = "eks-nodegroup"
  }

  scaling_config {
    desired_size = 1
    min_size = 1
    max_size = 1
  }

  launch_template {
    id      = aws_launch_template.test-launch-template-yeogunna.id
    version = aws_launch_template.test-launch-template-yeogunna.latest_version
  }

  tags = {
    "Name" = "${aws_eks_cluster.test-eks-cluster.name}-worker-node2"
  }
}