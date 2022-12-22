### HPA Autoscaling 적용
1. HPA Autoscaling 적용 
# 1-1. Test용 POD배포
- kubectl apply -f test-deploy.yaml (Deployment, Service)
# 1-2. HPA 적용
- kubectl autoscale deployment test-deploy --cpu-percent=50 --min=1 --max=10
- (HPA 배포 확인) kubectl get hpa
- kubectl get hpa test-deploy -o yaml 
> metadata.annotations 정보 확인

2. CPU 부하테스트
- kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://test-deploy; done"
- kubectl get po/hpa
- kubectl describe hpa test-deploy

