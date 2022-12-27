### kubernetes Operator 적용
1. Operator Directory구조
- operator.yaml: 메타데이터, 라이프사이클 정의
-   maintainers/tasks/plans
- params.yaml
- templates

2. kudo 설치
# 1. kudo plugin & binary install
- wget https:// github.com kudobuilder /kudo/releases/download/v0.19.0/kubectl kudo_0.19.0_<OS 종류>_x86_64
- chmod +x kubectl kudo_0.19.0_ OS 종류 >>_x86_64 && mv kubectl-kudo_0.19.0_<OS 종류>_x86_64 /usr/local/kubectl-kudo 
> OS 종류 리눅스 linux , 맥 darwin
# 2. kudo 설치확인
- kubectl kudo --version
# 3. cert-manager 설치
- kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.0/cert manager.yaml
- (확인) kubectl get po -n cert-manager
# 5. kudo 설치 초기화 진행
- (배포하기위한 상위 dir) kubectl kudo init
- (확인) kubectl get po -n kube-system 
> kudo-controller-manager

3. kudo를 사용한 Operator 생성
# 1. operator 생성 명령어
- (생성) kubectl kudo install <dir>/
- (확인) kubectl kudo get operators/instances
- (componet확인) kubectl get all -o yaml
> object/deploy 확인

4. kudo를 사용한 Operator 업그레이드
- params.yaml: replicas 1>2, appversion >latest
- (upgrade) kubectl kudo upgrade <dir>/ --instance <instance>
- operator.yaml: operatorVersion > 0.1.1 / appVersion > latest
> componet/object/deploy 확인
