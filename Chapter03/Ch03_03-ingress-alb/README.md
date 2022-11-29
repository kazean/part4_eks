1. 초기설정
- ec2.instance.tf 주석
- iam-instance_profile.tf 주석
- iam-roles.tf bastion 주석
- security-group.tf Bastion 주석
- iam-policy.tf bastion 주석
- backend 설정
>terraform

2. ec2 bastion 설정
- 위 주석부분 해제하며 Bastion provisioning
>terraform

3. namespace, deployment, service 배포
- kubectl, aws cli
ssh -i (bastion)

4. aws ALB Controller - #1
- eksctl ALB Controller 설치
- IAM Policy 설정
(iam-policy) 복사 > iam-policy.tf json 부분 대체
terraform 
kubernetes Service Account 를 Object를 쉽게 만들기 위한 eksctl
eksctl create iamserviceaccount \
--cluster=<EKS Cluster명> \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::<AWS 계정ID>:policy/AWSLoadBalancerControllerIAMPolicy \
--override-existing-serviceaccounts \
--approve

OIDC Provider 접근가능 권한 < > eks cluster aws alb 생선관리권한
Service 계정 
kubectl get sa -n kube-system (aws-load-balancer-controller)

4. aws ALB Controller - #4
- alb controller 배포
--cluster-name 설정
cert-manager 먼저 배포해야 alb controller 배포가능
> kubectl get po -n kube-system (aws-load-balancer-controller)
> kubectl get deploy -n kube-system aws-load-balancer-controller

5. Ingress Annotation 설정 및 배포
test-ingress.yaml
internet-facing or internal(private)
target-type: ip (pod의 경우), instance (instance)
subnets: alb가 어떤 subnet을 걸쳐서 트래픽 받을건지