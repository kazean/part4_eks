Error: creating Auto Scaling Group (init-eks-autoscale-grp): ValidationError: You must use a valid fully-formed launch template. Value (init-eks-template) for parameter iamInstanceProfile.name is invalid. Invalid IAM Instance Profile name
│       status code: 400, request id: d808893d-1b3b-4f46-84f6-f6bce7a492e9
│
│   with aws_autoscaling_group.init-eks-autoscale-grp,
│   on autoscaling_group.tf line 2, in resource "aws_autoscaling_group" "init-eks-autoscale-grp":
│    2: resource "aws_autoscaling_group" "init-eks-autoscale-grp" {
│
╵
╷
│ Error: error waiting for EKS Node Group (test-eks-cluster:test-eks-nodegroup2) to create: unexpected state 'CREATE_FAILED', wanted target 'ACTIVE'. last error: 1 error occurred:
│       * i-0cba89f20a5dca9b7: NodeCreationFailure: Instances failed to join the kubernetes cluster
│
│
│
│   with aws_eks_node_group.test-eks-nodegroup2,
│   on eks-nodegroup.tf line 30, in resource "aws_eks_node_group" "test-eks-nodegroup2":
│   30: resource "aws_eks_node_group" "test-eks-nodegroup2" {


Error: error waiting for EKS Node Group (test-eks-cluster:test-eks-nodegroup2) to create: unexpected state 'CREATE_FAILED', wanted target 'ACTIVE'. last error: 1 error occurred:
│       * i-0d1b0991192173017: NodeCreationFailure: Instances failed to join the kubernetes cluster
│ 
│ 
│ 
│   with aws_eks_node_group.test-eks-nodegroup2,
│   on eks-nodegroup.tf line 30, in resource "aws_eks_node_group" "test-eks-nodegroup2":
│   30: resource "aws_eks_node_group" "test-eks-nodegroup2" {

>> arn:aws:sts::<AWS_ID>:assumed-role/AWSServiceRoleForAmazonEKSNodegroup/EKS launch_template role 때문인것같음