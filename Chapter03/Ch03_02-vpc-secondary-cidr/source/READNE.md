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
3. subnet, route_table, route_table_association 확인
4. CRD, ENIConfig 및 AWS CNI Config 설정 
- 4.1 crd, eniconfig.yaml 배포
kubectl create -f .
kubectl get eniconfig
- 4.2 AWS CNI Config 설정
kubectl set env daemonset aws-node -n kube-system AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG=true
kubectl set env daemonset aws-node -n kube-system ENI_CONFIG_LABEL_DEF=failure-domain.beta.kubernetes.io/zone
5. eks node 수동 전환
- 노드개수 1 > 2 새로운 노ㅡ에는 label 이 추가되어져서 생성된다
- deployment, daemonset rollout, scale
kubectl rollout restart deploy <Deployment명>
kubectl scale deploy <Deployment명> --replicas=<증가수량>

6. eks node 수동 전환 2 > 1
- ds, deploy rollout, scale 후 확인