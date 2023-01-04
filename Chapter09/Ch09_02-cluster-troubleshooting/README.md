### CH09-02 Cluster 로깅 및 이슈 사례 조치방법
# cf, 환경구성후 테스트

1. Container Insight 연동을 위한 EKS 구성방법
- cwagent-fluentbit.yaml
- configMap aws cluster명 region 설정
> kubectl get all -n amazon-cloudwatch (daemonset, po) > cloudwatch-agent, fluentbit
> cf, 수집 시간이 필요

2. Cluster Logging 실습방법
- kubectl cluster-info
> kubernetes control plan, CoreDns status
- kubectl cluster-info dump

4. Container Insights를 통한 Kubernetes Metrics확인
# 4-1 IAM Role을 Nodegroup에 CloudWatch 정책추가하여아함: CloudWatchAgentServerPolicy
# 4-2 Log Group을 통한 Kubernetes Cluster log 수집 현황 확인

5. Cluster 이슈 발생시 확인 방법
# 5-1 KMS
- AWS EKS > Cluster > <Cluster명> > 구성 > 세부 정보 > 암호 암호화
- AWS Key Management Service(KMS) > 고객 관리형 키
# 5-2 EKS Subnet
- Master Node 개수, subnet 대역대 중복 
> 2개 이상의 나눠진 zone의 subnet
> 서비스의 IPv4와 subnet 대역은 달라야함.
# 5-3 EKS Update
> Support

# 5-4 AWS 이슈 확인
- Health Dashboard
