### CH08-10 AWS ACM활용 TLS 인증서 관리
2. 사전준비사항
- eks cluster, domain add, alb
3. AWS ACM을 통한 TLS 인증서 발급
- AWS: Certification Manager
- Public: *.domain
- DNS 검증 수행 명령어: dig +short <DNS 검증 domain address>
4. 테스트용 k8s Object 배포
# deployment
# ingress (test-ingress.yaml)
- metadata annotations.alb.ingress.kubernetes.io/subnets, actions.ssl-redirect, certificate-arn, listen-ports
5. Route53 도메인 등록 및 검증
- 레코드 생성 > A Class > 별칭