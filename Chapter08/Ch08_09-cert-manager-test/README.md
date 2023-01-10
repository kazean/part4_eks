### CH08-09 cert-manager를 활용한 TLS 인증서 관리
1. 사전준비
- EKS, Domain 주소(Route53)
# Domain 
- fastcampus.click >
- (default) setting ns 

2. Ingress-Nginx 설치 (Helm chart)
> helm install ingress-nginx ./
> service elb
2. Cert-Manager를 통한 TLS 인증서 발급
# cluster-issuer.yaml (apply)
- setting email, class
> kubectl get issuer/clusterissuers
> kubectl describe issuer <name>

3. test용 k8s manager object 배포
# test-ingress.yaml
- metadata.anntations.kubernetes.io/ingress.class: "nginx"
-   cert-manager.io/acme-challenge-type: "http01"
-   cert-manager.io/cluster-issuer: "letsencrypt-prod"

- spec.tls.hosts/secretName 
> hosts: test.gunna-test.click, secretName: ing명
> 설정후 배포
>> po, svc(ClusterIP), ing, secret
>> host: 지정 host, address: nginx elb

- kubectl get certificate
> status가 false이기에 true로 변경해줘야함
>> (X) kubectl edit certificate ingress-2048 >> 5번 하면 자동으로 true

5. Route53 도메인 등록 및 HTTPS 접속 검증
# 레코드생성
- 레코드 이름: prefix로 지정한값
- 레코드 유형: CNAME 
- 값: nginx elb dns
# 확인
- prefix.fastcampus.click > 
- https://prefix.fastcampus.click >

