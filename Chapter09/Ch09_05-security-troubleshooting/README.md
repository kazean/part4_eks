### CH09-05 보안관련 로깅 및 이슈 사례 조치방법
0. 실습 아키텍쳐 구성사항
# 1. AWS EKS
- VPC: 1, Public Subnet: 2, igw: 1
- EKS Cluster: 1, EKSNodeGroup: 1(2개 WorkerNode)
# 2. terraform-backend Provisioning
# 3. Ingress구성을 위한 IAM Policy 적용(ALB)
- iam_policy.json
- aws iam cretea-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
- eksctl create iamserviceaccount \
--cluster=<cluster> \
--namespace=kube-system \
--name=aws-load-balancer-controller \
--role-name "AmazonEKSLoadBalancerControllerRole" \
--attach-policy-arn=arn:aws:iam::<AWS_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
--approve
# 3-1. Helm Chart Reposotory 등록 및 ALB 배포
- helm repo add eks https://aws.github.io/eks-charts
- helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
 -n kube-system \
 --set clusterName=<Cluster> \
 --set serviceAccount.create=false \
 --set serviceAccount.name=aws-load-balancer-controller
# 4. 예제를 위한 마이크로서비스 배포 (k8s-manifests)
- test-ingress.yaml: set subnet
- kubectl apply -f ./
# 5. Master Node Control Plane Logging
- EKS > Cluster > <Cluster> > 로깅관리

3. 보안 로깅 방법 실습
# 1. Access Log 접속 및 처리내역  확인
- CloudWatch > /aws/eks/<eks>/cluster/authenticator
# 2. Audit Log 보안 취약점 확인
- CloudWatch > /aws/eks/<eks>/cluster/kube-apiserver-audit
# 3. CloudTrail Log를 통한 AWS API Audit 로그 확인
# CloudTrail 생성 후 확인 가능
- CloudWatch > 로그그룹 > aws-cloudtrail-logs
# 4. WAF Log를 통한 웹 보안 침입 탐지 로그 확인
# WAF & Shield 생성시 loggin에서 생성
- CloudWatch > aws-waf-logs

4. 보안 이슈  사례 발생시 확인 방법 실습
# 1. 침입탐지/보안 취약점     발견(WAF)
- AWS WAF > Web ACLs > (생성된Web ACLs 선택) > Overview
# 2 특이 API호출 발견/공격 시도 탐지(CloudTrail)
- AWS CloudTrail > 이벤트기록 > 전체이벤트기록보기

### CH09-06 DNS 로깅 및 이슈 사례 조치방법
3. CoreDNS 튜닝 설정
- route53 직접 연동, cache(ttl 시간 증가)
- kubectl edit cm coredns -n kube-system
- Corefile: |
    fastcampus.click { # DNS 도메인명추가
    route53 fastcampus.click.:Z09958083P088Y5E7ZP8H # Route53 Hosted Zone ID추가
}
.:53 {
    cache 60 # 30 -> 60변경
    log
}

4. DNS 로깅 방법 실습
# 1. coreDNS 로깅 활성화
# 2. nslookup
- nslookup www.naver.com
- 다른 cname들 검색(cname 쿼리): nslookup -q=cname www.naver.com
- 특정 DNS 서버 적용한 쿼리: nslookup www.naver.com 1.1.1.
# 3. dig
- dig www.naver.com
- dig +short www.naver.com
- dig cname www.naver.com
- dig @8.8.8.8 www.naver.com
> cf, 8.8.8.8 google dns server
- dig +trace www.naver.com
# 4. route53 로깅
- route53 > 쿼리 로깅 구성(CloudWatch)
- (us-east1 리전 버지니아)CloudWatch > 로그 > 로그 그룹 > /aws/route53/<지정한 로그 그룹명>
> 사실 큰 의미가 없다. >> WAF Log를 사용하는 것이 낫다

5. DNS 이슈 사례 발생시 확인 방법 실습 
# 1. DNS 쿼리 이슈
# 1-1. DNS 디버깅용 임시 POD 배포 
- kubectl apply -f https://k8s.io/examples/admin/dns/dnsutils.yaml
# 1-2. POD sh 접속하여 DNS 쿼리
- kubectl exec -it <대상POD명> ‒ sh
> nslookup, dig
- vi /etc/resolv.conf 설정 및 nslookup kubernetes 10.100.0.10 쿼리수행
# 2. DNS 성능 이슈
# 2-1. Deployment에 dnsConfig 설정 
- Manifest 또는 kubectl의 edit spec.template.spec.dnsConfig부분
- dnsPolicy: ClusterFirst
    dnsConfig:
        options:
        - name: ndots
          value: "1"
# 2-2. ndot 적용 및 DNS 도메인 FQND화
- 특정 도메인 맨 끝에 '.'(Dot)을 추가하면 해당 도메인은 FQDN으로 인식
# 3. CoreDNS 튜닝
- 3에서 적용한 것과 같음
