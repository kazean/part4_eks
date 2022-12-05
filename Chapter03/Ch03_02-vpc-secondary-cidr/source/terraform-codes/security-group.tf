#security group create
resource "aws_security_group" "test-sg-eks-cluster" {
  name = "test-sg-eks-cluster"
  description = "security_Group for test-eks-cluster"
  vpc_id = aws_vpc.default-vpc.id

  tags = {
    Name = "test-sg-eks-cluster"
  }
}

#firewall
resource "aws_security_group_rule" "test-sg-eks-cluster-ingress" {
    security_group_id = aws_security_group.test-sg-eks-cluster.id
    type = "ingress"
    description = "ingress security_group rule for test-eks-cluster"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "test-sg-eks-cluster-egress" {
    security_group_id = aws_security_group.test-sg-eks-cluster.id
    type = "egress"
    description = "egress security_group rule for test-eks-cluster"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]

}

### SECONDARY CIDER
#security group create
resource "aws_security_group" "test-sg-eks-pods" {
  name = "test-sg-eks-pods"
  description = "security_Group for pods"
  vpc_id = aws_vpc.default-vpc.id

  tags = {
    Name = "test-sg-eks-pods"
  }
}

#firewall
resource "aws_security_group_rule" "test-sg-eks-pods-ingress" {
    security_group_id = aws_security_group.test-sg-eks-pods.id
    type = "ingress"
    description = "ingress security_group rule for test-sg-eks-pods"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "test-sg-eks-pods-egress" {
    security_group_id = aws_security_group.test-sg-eks-pods.id
    type = "egress"
    description = "egress security_group rule for test-sg-eks-cluster"
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]

}