# 사전준비사항
0. 사전준비사항
- ingress-alb 와 같음 (Bastion 서버)
- Private routing > nat, Public routing > igw
- [instance profile 존재 에러시]
# $ aws iam list-roles
# $ aws --region=ap-northeast-2 iam delete-instance-profile --instance-profile-name test-ec2-instance-profile

1. Namespace 구성 및 예제 Deployment 배포
- namespace 생성
kubectl create ns test-service-nlb
- yaml 작성 (test-deployment-nginx.yaml, test-service.yaml)
metadata:
  service.beta.kubernetes.io/aws-load-balancer-type: external 
  >> nlb로 해야 작동
  service.beta.kubernetes.io/aws-load-balancer-nlb-target-type: ip
  service.beta.kubernetes.io/aws-load-balancer-scheme: internet-facing
  service.beta.kubernetes.io/subnets: <Public Subnet1 ID>, <Public Subnet2 ID>
- 배포
kubectl create -f ~.yaml

2. Network Load Balancer 확인 및 접속
- EC2 console > 로드밸런서 확인
- dns web browser 확인