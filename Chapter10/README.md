### CH10-04 Kubernetes API 활용 모듈 구현
# 4. [실습] go
1. GO DIR
- cdk8s/dist: 만들어지는 yaml
- imports: package mod
- go.mod, go.sum
- package.json: cdk8s.yaml info (= cdk8s/cdk8s.yaml)
- main.go
>  import, 구조체

### CH10-05 Kubernetes CLI 빌드 및 실행
# 1. GO 언어 기반 Microservice 컨테이너 빌드 및 AWS ECR PUSH
1. go 언어 기반 Microservice 컨테이너 빌드 
- (~/container) docker build -t <AWS_ECR_REPO>:<TAG> .
> <AWS_ECR>:1.0 .
2. AWS ECR 로그인 
- aws ecr get-login-password --region ap-northeast-2 | docker login \ --username AWS --password-stdin 939823608919.dkr.ecr.ap-northeast-2.amazonaws.com/web-text-box
3. AWS ECR로 빌드된 컨테이너 PUSH
- docekr push <AWS_REPO>:<TAGH>
# 2. go 언어 기반의 모듈로 Kubernetes Custom CLI 빋르 및 실행
0. cdk8s
- main.go 
> k8s.NewKubeDeployment(chart, jsii.String("deployment"), &k8s.KubeDeploymentProps{
>   ..Image: jsii.String("939823608919.dkr.ecr.ap-northeast-2.amazonaws.com/test:1.0"),
1. go 언어 기반 모듈로 k8s build를 위한 Dependcy Import
- cdk8s import
2. go 언어 기반 모듈로 Kubernetes Cusotm CLI 빌드 및 실행
- cdk8s synth