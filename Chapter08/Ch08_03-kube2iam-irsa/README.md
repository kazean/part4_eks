### [Ch08-02 eksctl OIDC 생성]
1. IRSA용 OIDC 생성
- eksctl utils associate-iam-oidc-provider --cluster <EKS클러스터명> --approve
2. 생성된 IRSA OIDC URL 확인
- aws eks describe-cluster --name <EKS클러스터명> --query "cluster.identity.oidc.issuer" --output text
3. 생성된 IRSA OIDC ARN 확인
- aws iamlist-open-id-connect-providers | grep <(2)번에서나온ID값입력>

### [Ch08-03 kube2am를 활용한 AWS IAM기반 권한 관리]
1. 사전준비
- eks: test-eks-cluster
- s3: test-dev-k8s-s3-bucket >
> file upload
- dymnamodb: test-dev-k8s-ddb-table 
> key(String), index(String)
- iam-policy.json
> s3, dynamodb setting
2. IAM Policy 적용
- aws iamcreate-policy \
--policy-name <생성할IAM Policy명> \ 
--policy-document file://iam-policy.json
> policy: test-iam-policy-s3-ddb
3. IRSA 적용 (eksctl)
- eksctl create iamserviceaccount \
--name <IRSA명> \ 
--namespace <적용할EKS내Namespace명> \
--cluster <EKS 클러스터명> \
--attach-policy-arn arn:aws:iam::<AWS 12자리계정ID>:policy/<2번에서
생성한접근할Resource의IAM Policy명> \
--approve
> IRSA: test-irsa-s3-ddb
>> Role(OIDC Provider), 해당 Policy 적용
4. IRSA 검증
# 1. pod 배포
# 2. pod bash shell 실행
# 3. Assume role에 의해 발급된 임시 토근 권한(STS) 확인 명령어
- aws sts get-caller-identity
# 4. s3 파일 목록 출력
- aws s3 ls s3://<s3 bucket>
# 5. s3 bucket 내 특정 파일 삭제
- aws s3 rm s3://<s3 bucket>/<file>
# 6. dynamodb table 정보 출력
- aws dynamodb describe-table --table-name <table>
# 7. dynamodb table delete
- aws dynamodb delete-table --table-name <table>
# 8. 권한 추가하여 테스트하기
- aws s3 console
- dynamodb permmision: delete table
- s3 permmision: delete object