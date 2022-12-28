### CH08-04 Falco 소개 및 설치
2. 사전준비사항
- 기존 eks cluster
3. IAM Policy 및 Role 적용
# 1. Falco 로그 대상 Cloudwatch용 IAM Policy 적용 명령어
- aws iam create-policy --policy-name EKS-CloudWatchLogs --policy-document file://iam_role_policy.json
# 2. Falco 로그 대상 Cloudwatch 연동용 IAM Role 적용 명령어
- aws iam attach-role-policy --role-name <EKS Worker Node Role명> --policy-arn `aws iamlist-policies | jq -r '.[][] | select(.PolicyName =="EKS-CloudWatchLogs") | .Arn'`
4. Falco 설치
# values.yaml
- jsonOutput: false > true
# falco direction
- values.yaml
- rules 