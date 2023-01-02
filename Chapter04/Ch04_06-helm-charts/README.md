# Helm Charts remote Repo
1. helm remote repository
helm repo add stable https://charts.helm.sh/stable
helm repo list
helm repo remove test-repo
helm repo add test-repo https://charts.bitnami.com/bitnami

2. Nginx container pod 배포/기동
helm search repo nginx
helm repo update
> 검색을 최신버전으로 업데이트
# test-repo/nginx 9.9.0
helm install nginx test-repo/nginx --version 9.9.0
helm ls/list
helm status nginx
- 최신버전 업그레이드
helm upgrade nginx test-repo/nginx --version 9.9.3
- helm history
helm history nginx
- helm rollback
helm rollback nginx 1

3. helm fetch
# repository 에 있는 nginx로 가져와야된다 기동되어있는 chart는 가져올 수 없음
helm fetch --untar test-repo/nginx --version 9.9.0
# 파일구성 보기
- Chart.yaml
name, version, appVersion
- values.yaml
image.tag: image버전
# 기존 배포 삭제
helm uninstall nginx

4. custom 파일기반으로 배포
helm create test

## Description ##
tree
- Chart.yaml
- values.yaml
image.tag: "1.16.0" 
> apiVerson과 맞춤
service, ingress, autoscaling(HPA)
# templates
deployment/hpa/ingress/service/serviceaccount.yaml,
 ex) {{ include "test.fullname" . }} >> values.yaml or _helpers.tpl
- NOTES.txt
- _helpers.tpl
템플릿간 사용하는 Dynamic변수 등을 정의
- tests
test-connection.yaml

- 문법 검증
helm lint <Chart dir>
ex) values.yaml 
enable: true
> annotations.kubernetes.io 주석 해제 후 lint
> annotaions: {} 을 지운 후 다시 lint

- template을 Manifest Object구현 단위 보기
helm template <Chart dir>
kubectl create -f <dry-run>.yaml
> 배포되지 않음 ex) [ERR] RELEASE-NAME > nginx
>> 바꾼후 재배포
test-connection pod status : complete
kubectl logs nginx-test-connection-~~
kubectl delete -f <dry-run>.yaml

- 압축된 형태로 chart를 repository에 올리기 위해 package 화 
helm package test
> test-0.1.0.tgz, tar xvfz ~.tgz
- 현재 디렉터리 helm 배포
helm install nginx <chart dir>
- test하기
helm test nginx

- helm template과 package 비교
helm show chart <chart dir>
helm show all <chart dir>
helm template <chart dir>
- helm status nginx (NOTES.txt)
{{- if .Values.ingress.enabled }}
- deploymeunt.yaml
_helpers.tpl ex) test.fullname
- hpa.yaml
values.yaml
> autoscaling.enable: true 
> autoscaling.minReplicas/maxReplicas: 2/4
helm upgrade nginx .
>> hpa 추가 확인 cf, upgrade로는 pod가 늘어나진 않는다.?
- service.yaml
values.yaml
> service: ClusterIP > NodePort
helm template .
helm upgrade nginx .

