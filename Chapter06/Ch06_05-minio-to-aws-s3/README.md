### Minio Gateway
1. custom 설정 확인
# mode, service.ports
# auth.rootUser: admin
- admin이지만 aws Access Key로 접속
# gateway
- ~.enabled: true
- ~.type: s3
- ~.replicasCount: 1 // 이상 설정시 추가 설정
- ~.s3: accessKey/secretKey/serviceEndpoint

2. helm 설치
- (기존 Helm은 지운후 배포) helm install minio-to-aws-s3 ./
- (확인) kubectl get all
3. Minio 접속
4. Minio를 통한 AWS s3 bucket 생성
- create bucket: test-minio-s3-bucket

