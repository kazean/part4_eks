#EKS Node 및 POD IP 대역 분리
1. VPC에 Secondary CIDER 추가
- VPC > 작업 > CIDER편집 > 새 IPv4 추가
- 설정 내역 : 100.64.0.0/16
2. Terraform에 Secondary CIDER Subnet, Route, Security group 추가
- subnet.tf
public-subnet-eks-pods-a/c 
100.64.0.0/19, 100.64.32.0/19
- route_table.tf
test-eks-pods-a/c 
- route_table_assocication.tf
test-rta-eks-pods-a/c
- security_group.tf
