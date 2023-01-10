### CH11 Kubernetes 미니프로젝트 수행 하기
## CH11-01 K8s활용 미니프로젝트 소개
# AWS Infra 구성내역
- (네트워크) AWS EKS Setting
> Route53, ACM, ALB Ingress Controller
- (스토리지) 
> ECR, EBS, S3, DynamoDB, ACM
# 플랫폼 구성내역
- EKS Cluster
- 추가 플러그인: AWS ALB Ingress Controller
> kubectl get po -A 


## CH11-02 CI 환경 설정 및 빌드 준비하기
# 1. Jenkins 소개 및 custom settings
- management/ci/jenkins
1. settings
- pvc.yaml, sa.yaml
2. helm-charts
- values.yaml
> 1)ingress
>> enable false > true
>> ~.annotations: alb setting
>> ~.hostName: jenkins.fastcampus.click
> 2)persistence
>> existingClaim: jenkins-pvc
>> storageClass: gp2
>> accessMopde, size 
> 3)serviceAccount
>> create, name

# 2. Jenkins용 SA 및 Persistence Volume 적용
- k8s settings
> kubectl create namespace jenkins
> kubectl apply -f sa.yaml
> kubectl apply -f pvc.yaml

# 3. Jenkins Helm Charts 설정 및 배포
1. Jenkins REPO 등록 및 2. 검색
> helm repo add jenkinsci https://charts.jenkins.io
> helm search repo jenkinsci
>> jenkinsci/jenkins
3. Jenkins Helm Chart 설정
- values.yaml: ingress, persistence, serviceAccount
4. 배포
> helm install jenkins -n jenkins -f values.yaml jenkinsci/jenkins
5. ing 정보 확인
6. jenkins Route53 도메인 등록
- DNS 관리 > 호스팅 영역 > <domain> > 레코드 생성 > jenkins, A 레코드, 별칭
7. jenkins admin 암호 확인
> kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/chart-admin-password && echo
- 패스워드 변경

# 4. Jenkins Plug-in 설치
1. 플러그인 경로
- 메인화면 > Jenkins 관리 > 플러그인 관리 > 설치가능
2. Jenkins 플러그인 설치 대상
- pipeline, aws, github, ssh, docker, kubernetes
> Pipleline
>> Github branch Source, Pipeline:Github Groovy Libraries, Docker Pipeline, Pipe, Pipeline: Declarative Agent API, Pipe Utility Steps, Build Pipeline
>> SSH Pipeline Steps, GitHub Organization Folder, Pipeline: AWS Steps, Delivery Pipeline, Pipeline:GitHub
> AWS
>> CloudBess AWS Credential, Amazon ECR, AWS Global Configuration
> Github
>> Github, Github API, Github Integration, GitHub Authentication
> ssh
>> SSH, SSH Build Agents, Pushlish Over SSH, SSH Agent, 
> docker
>> Docker, Docker coomons, Docker API, docker-build-step, CloudBess, Docker Build and Publish, Docker Siaves
> kubernetes
>> Kubernets CLI, Kubernetes Coutinuous Deploy, Kubernetes Credential Provider, Kubernets::Pipeline::DevOps Steps

# 5. Github AWS Credential 설정
1. Github 연결용 SSH Key 생성
- ssh-key/jenkins-github-key
> ssh-keygen -b 2048 -t rsa -f id_rsa
2. Github 연결 설정
- Github SSH and GPG keys: jenkins-github-key (Public Key)
3. AWS Key 등록
- System Configuration > AWS
- ID: aws-key, Access Key & Secret
- 2) Git hub ssh 키 등록
> Security > management credential > Jenkins > Global credential > Add Credential: github-key (Private SSH Key)


### Ch11-03 CD 환경 설정 및 배포 준비하기
# 1. ArgoCD 설치
- namespace 생성
> kubectl create ns argocd
- argocd 배포
> kubectl apply -f install.yaml
- ingress.yaml
> argo-cd.fastcampus.click

# 2. ArgoRollout 설치
- namespace 생성
> kubectl create ns argo-rollouts
- argo Rollout 설치
> kubectl apply -f install.yaml

# 3. ArgoCD 대상 Ing 구성
- argoCD Ing 배포
> kubectl apply -f ingress.yaml
>> kubectl get ing -n argocd
- argoCD Route53 도메인 등록

# 4. ArgoCD CLI 설치 및 비밀번호 변경 및 로그인
1. argoCD CLI Install
> brew install argocd
2. argoCD Login 수행
> (비밀번호 확인)kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
3. argoCD Login > argocd login <ArgoCD DNS 도메인명> 
> admin 위 stdout pw 입력
4. argoCD 비밀번호 변경
> argocd account update-password
5. argoCD 접속
> https://<domain>:443

# 5. argoCD내 미니프로젝트용 Repo 연동
1. Repo 연동 경로
- 톱니 바퀴 > Repositories
2. ssh key 생성
> ssh-keygen -t ed25519 -a 100 -f <ssh-key명>
3. Git hub에 ssh key 등록
> :argocd-github-key
4. argocd ssh key 등록
- connecto repo using ssh
> name: mini-project, Project: default, Repo Url: ssh url, SSH private key data


### CH11-04 CI 빌드 수행 및 컨테이너 Push, Helm Charts Push 하기
# 1. 컨테이너 빌드를 위한 소스코드 확인
- 컨테이너 경로: Chapter11/mini-project/service/conatainer
- helm-charts (App)
- Jenkinsfile
> podTemplate 컨테이너 안에서 docker, argo cli 사용할 수 있도록 pod 실행

# 2. 컨테이너 Push 및 저장을 위한 AWS ECR 준비
- Local AWS ECR Login
> docker desktop 실행
> docker images/ps
>$ aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin <AWS ECR Repository URL>

# 3. CI 빌드 수행 및 컨테이너 Push 확인
1. docker build (~/container)
> docker build -build-arg COLOR=blue -t <AWS_ECR/test>:blue .
>> docker images
> docker push <aws_ECR/test>:blue

# 4. CD 배포를 위한 Helm Charts 코드 확인
- Chapter11/mini-project/service/helm-charts
> values.yaml 작성
# 5. argoCD 내 Application 생성 및 Helm Charts Push
- NEW APP
1. General
> App name: bubllepool, project: default, SYNC Policy: self heal/Auto-create namespace
2. Source
> REPO URL, Revison, Path
3. Destination
> cluster URL: default
> namespace: bubblepool
4. Helm
> values file: values.yaml 
>> CREATE
>> kubectl get ns
>> kubectl get all -n bubblepool
>> kubectl get ing -n bubblepool
>> kubectl get rollout -n bubblepool
> bubblepool ALB Route53 등록

# 6. Jenkinsfile 작성
1. 작성 경로
- mini-project/service/Jenkinsfile
2. def 변수값 입력
- def awsECRURL="<AWS ECR URL>"
- def awsKey="<Jenkins 내AWS Credential명>"
- def awsRegion="<ECR 적용리전>"
- def branch="<Github repository branch명>"
- def directoryPath="<Jenkinsfile이있는Path>"
- def githubKey="<Jenkins 내설정된Github Credential명>"
- def githubSSHURL="<Github Repository의SSH URL 주소>"
- def imageTag="<Bubble App Color>"

# 7. Jenkins Pipeline 설정
> 새로운 아이팀 > mini-project > Github Project: project url
> Pipe line: pipeline script from SCM > Git > <REPO SSH URL>
> Script Path: 상대경로 지정


### Ch11-05 CD 자동 Trigget 및 배포 - 기동 상태 확인하기
# 0. 실습전 사전 수행사항
1. Jenkins File내 imageTag변경
- blue > green
2. git commit & Push
3. 적용후 Jenkins Pipeline 에서 Build Now 수행
> helm charts values.yaml > argoCD (Sync 3min)
>> green


### Ch11-06 Canary 배포 적용 및 무중단 버전 업데이트 하기
# 1. Canaray 배포 적용 코드 확인 및 image 변경
1. helm-charts rollout.yaml
- kind: rollout
- spec.strategy.canary.maxUnavailable/steps
2. Jenkins file
- green > red
- commit & Push
# 2. Canaray 배포 적용을 위한 CLI 및 Dashboard 준비
1. 설치 및 기동
> brew install argoproj/tap/kubectl-argo-rollouts
> kubectl argo rollouts dashboard
> >(확인) kubectl argo rollouts get rollout bubblepool -n bubblepool -w
> >jenkins Build Now
