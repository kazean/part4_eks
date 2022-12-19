### [실습 Ch05-02 GitOps] Git Repository 생성 및 설정
1. Git repository 생성
- platform-repository
- managemet-repository
- service-repository
- gitops-repository

2. ssh 관리를 위한 key 생성 및 Github 등록
- 생성
ssh-keygen -q -t rsa -N '' -m PEM -t rsa -b 4096 -C test -f ./id_rsa <<<y >/dev/null 2>&1
>> ssh-keygen -t ed25519 -C "argocd" -f argocd?
- 등록
(MAC) OS
ssh-add id_rsa
(Linux)
eval `ssh-agent`
ssh-add id_rsa
- git에 SSH and GPG keys 등록

3. ~4 git repository 구성확인
- gitops-repo/service-repo/application.yaml
git@github.com:<사용자Org명>/service-repository.git
- gitops-repo/management-repo/kustomization.yaml
https://github.com/<사용자Org명>/management-repository//argocd?ref=main
- gitops-repo/platform-repo/iac.yaml
git@github.com:<사용자Org명>/platform-repository.git//aws/apnortheast-2/terraform-backend?ref=main
5. GitOps를 통한 Terraform으로 AWS 인프라/플랫폼 프로비저닝


### [실습 Ch05-04] ArgoCD 구성
1. ArgoCD 설치 및 Web UI 접속
- manifests desc
gitops-repo/management/manifests/kustomization.yaml
> management-repo manifest연결
- install sh desc
gitops-repo/management/argo-cd/scripts/setup.sh
> 결과 ArgoCD Web UI의 admin passwd

2. Repository 및 SSH 설정
- WEB UI Repository ssh 연결설정

3. 실습 
- Argo CD 설치 및 UI 접속
chmod +x setup.sh && ./setup.sh
gitops-repository/argo-cd/scripts/setup.sh
kubectl get svc -A
> argocd LoadBalancer 
- git repository 연결
톱니 > Repositories > Connect REPO USING SSH 
Name: service-repository
project : default
RepoUrl : (service-repository.git ssh)
SSH Pirvate Key : id_rsa
> connect

### [실습 Ch05-05 ArgoCD를 활용한 kubernetes Manifest배포]
1. Gitops Service 구현 형태 확인
- gitops/service/~Service/
~/guestbook/application.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application

2. service-repo 구현 형태 확인
~/guestbook/~deployment,svc.yaml

3. 실습
# 3-1. 배포
gitops/service/guestbook
kubectl apply -f application.yaml
- argo cd WEB UI 확인 
토폴로지 구성 및 상태 확인
kubectl get application -n argocd
kubectl get all -n guestbook
# 3-2. Desired State 검증
- pod 삭제 및 상태 확인
kubectl get po -n guestbook
kubectl delete po ~ -n guestbook
kubectl get po -n guestbook
> 재생성 
- pod scale out
kubectl get deploy -n guestbook
kubectl scale deploy guestbook-ui --replicas=3 -n guestbook
> scale이 변하지 않음
kubectl edit deploy guestbook-ui -n guestbook
replicas: 1 > 3
> replcas 변하지 않음
# 3-3. gitOps 검증 
- deployment Manifest를 변경해보기
service-repository/guestbook/guestbook-ui-deploymet.yaml
replicas 1 > 3
> argoCD 자동변경 default 3min or Sync/Refresh
kubectl get deploy -n guestbook
kubectl get po -n guestbook
# cf, LoadBalancer
- 상태점검, 보안그룹
service-repository/guestbook/guestbook-ui-svc.yaml
1) argo web UI 
protocl: TCP > http 
Refresh
2) ide
targetport, protocol delete
> Sync

- svc type: NodePort > ClusterIP로 변경 
type: NodePort > ClusterIP
externalTrafficPolicy > delete
> commit&Push > Refresh > Diff

### [실습 Ch05-06 Argo rollout 구성]
# 1. Argo Rollout 및 플러그인 설치 스크립트경로
- gitops-repository/management/argo-rollout/scripts/setup.sh
chmod +x setup.sh && ./setup.sh
- Argo Rollout Dashboard를 Background로 기동
kubectl argo rollouts dashboard

- Argo rollout 배포 확인 & 플러그인 확인
kubectl get po -A
kubectl get all -n argo-rollouts
kubectl argo rollouts -h 
ex)kubectl argo rollouts get rollout guestbook -w
ps -ef | grep dashboard

cf, 
- argo-rollout/manifests/kustomization.yaml
resources:
- <management-repository>

# 2. Argo Rollout Dashboard를 Background로 기동 
http://localhost:3100

cf,
- management-repo/argo-rollout
install.yaml
kustomization.yaml

### [실습 Ch05-07 Argo Rollout을 활용한 무중단 배포]
# 1. Canary 배포 설정 (yaml서정)
- service-repo/bubblepool/rollout.yaml
kind: Rollout
spec.strategy.canary.steps
    - setWeight: 20
    - pause: {duration: 15}
# 2. Rollout Object 배포
- gitops/service-repo/bubllepoll/application.yaml
kind: Application
- 배포
kubectl apply -f application.yaml
# 3. CLI GUI 확인
- GUI
ArgoCD 
- CLI
kubectl get po -A
kubectl get all -n bubblepool
# 4. Bubble Pool Applicaiton 배포 확인
- CLI
kubectl get application
kubectl argo rollouts list rollout -n bubblepool
kubectl argo rollouts status <NAME>
kubectl argo rollouts get rollout <NAME> -n bubblepool [-w]
- GUI 
argo rollouts NLB:80
