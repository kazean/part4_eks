#Terraform, Terraform Backend, Terrafommer
1. AWS 내 Terrafom Backend 생성
- Terraformer설치
2. Terraformer를활용한기존EKS Autoscaling자원대상IaC코드추출
- terraform.tfstate 
- [terraform-backend] providers.tf, variables.tf
- terraform-backend.tf resource: aws_s3_bucket, aws_dynamodb_table
- terraform init, terraform plan(s3, dynamodb), terraform apply 
>  콘솔내 s3, dynamodb 확인
- s3 버킷에 기존 terrafrom.tfState 저장
[Ch02_05 terraform.tfState] 
aws s3 cp terraform.state s3://<S3 Backend Bucket명>/<저장할파일명>
- [terraformer] init.tf
terraformer import aws --regions=<리전명> --resources=<자원명ex)auto_scaling> --path-pattern=<추출한파일저장디렉토리명ex)auto_scaling>
- s3 bucket에서 설정파일가져오기
[download] aws s3 cp s3://<S3 Backend Bucket명>/<저장할파일명> .
terraform state list
- auto scaling, launch template import
terraform state mv -state-out=<기존Terraform Backend 상태파일저장경로> <추출Terraform Object명> <Import되서저장될Terraform Object명>
terraform state mv -state-out=<기존Terraform Backend 상태파일저장경로> <추출Terraform Object명> <Import되서저장될Terraform Object명>
[Upload] aws s3 cp terraform.state s3://<S3 Backend Bucket명>/<저장할파일명> 

3. 추출IaC코드를활용한2번째EKS NodeGroup생성및확인
-[terraform-code] autoscaling_group, launch_template을 autoscaling에서 복사하여 가져옴
-[eks-nodegroup] nodegroup 추가(depend on 제거, 이름변경, launch template 추가) [launch_template] launch template 추가
- launch_template, auto_scaling 오류제거
- providers s3 연결설정 
- terraform init, plan, apply

4. Terraformer를활용한기존AWS 네트워크자원대상IaC코드추출
-vpc, subnet, igw, route, route_table 자원 확인
terraformer import aws --regions=<리전명> --resources=<자원명> --path-pattern=<추출한파일저장디렉토리명>
> vpc, subnet, igw, route_table


5. 추출IaC코드를활용한Terraform 상태및형상파일에저장,관리
- [terraformer] s3 terraform state 가져오기
aws s3 cp s3://<S3 Backend Bucket명>/<저장된파일명> <로컬의다운로드위치>
- terraform state mv -state-out=<기존Terraform Backend 상태파일저장경로> <추출Terraform Object명> <Import되서저장될Terraform Object명>
- [terra-codes] 각 tf 파일 넣고 terraform init // dynamodb lock key 삭제
- terraform state replace-provider -auto-approve registry.terraform.io/-/awshashicorp/aws
- terraform init 
