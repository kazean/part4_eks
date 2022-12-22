### minio
1. Custom 설정확인(values)
# mode
- mode: standalone/distributed
# port
- containerPorts:
-   api: 9000
-   console: 9001
# service type
- service.type: LoadBalancer
2. Minio install(helm)
- helm install minio ./
- kubectl get all(po, svc, deploy)
3. Minio 콘솔 접속 및 Object 파일 업로드/다운로드 적용
# minio 콘솔 접속 
- https://<dns>:9001
# minio 버킷 생성
- create bucket: test-minio-bucket
# upload
- (File) kubectl 
- (Folder) kubernets
# download
