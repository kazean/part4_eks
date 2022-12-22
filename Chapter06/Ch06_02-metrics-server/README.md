### Metrics Server 설치
# 1. Metrics Server 배포
- kubectl apply -f metrics-server.yaml
- kubectl get po -n kube-system
- API Server 형태, HPA기준으로 해당 파드들을 설정