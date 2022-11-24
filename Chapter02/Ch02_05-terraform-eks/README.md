#Terrafom 으로 EKS 생성하기
1. tf 파일 작성
- variables.tf, providers.tf, security-group.tf, iam-rolese.tf
- eks-cluster, eks-nodegroup.tf

2. tf 명령어로 EKS 생성하기
- (tf 디렉토리) terraform init
- terraform plan
- terraform apply
- aws configure
- aws eks update-kubeconfig --region <region> --name <cluster-name>
- kubectl create -f .
- kubectl get po [-A Opt, --all-namespaces]
- terrafrom plan --destroy
- terraform destroy