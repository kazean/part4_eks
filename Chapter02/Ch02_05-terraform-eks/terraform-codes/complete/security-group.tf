#security group 생성
resource "aws_security_group" "test-sg-eks-cluster" {
  name        = "test-sg-eks-cluster"
  description = "security_group for test-eks-cluster"
  vpc_id      = "<VPC ID>"

  tags = {
    Name = "test-sg-eks-cluster"
  }
}

#방화벽
resource "aws_security_group_rule" "test-sg-eks-cluster-ingress" {

  security_group_id = aws_security_group.test-sg-eks-cluster.id
  #inbound: ingress, outbound: egress
  type              = "ingress"
  description       = "ingress security_group_rule for test-eks-cluster"
  #모든 포트: 0
  from_port         = 0
  to_port           = 0
  #모든 프로토콜: -1
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "test-sg-eks-cluster-egress" {

  security_group_id = aws_security_group.test-sg-eks-cluster.id
  type              = "egress"
  description       = "egress security_group_rule for test-eks-cluster"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}