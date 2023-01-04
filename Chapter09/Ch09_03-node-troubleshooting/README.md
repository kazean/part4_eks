### CH09-03 Node 로깅 및 이슈 사례 조치방법
# cf, 환경구성후 테스트

3. Node 로깅 방법 실습
# 3-1 kubectl Worker Node 상태 확인
- kubectl describe no <Worker Node 명>
> Conditions: status (Type, Reason)
>> Type: MemoryPressure, DiskPressure, PIDPressure, PID available Ready
> Address, Capacity
# 3-2 EKS Worker Node 현재 기준 CPU, Memory 사용량 정보 확인
- top 기능을 사용하기 위해 mertrics-server 설치 필요
- kubectl apply -f mertrics-server.yaml
> kubectl get po -n kube-system
- kubectl top node <Worker Node 명>
# 3-3 Container Insights를 통한 Worker Node Metrics (Node IAM Role 연동)
- CloudWatch > Insight > Container Insights
- <Cluster Filter> > 성능 모니터링 > EKS Nodes
# 3-4 Log Group을 통한 Kubernetes Worker Node 로그 수집 현황 확인
- AWS CloudWatch > 로그>로그그룹> /aws/containerinsights/<EKS명>/dataplane (daemon)
- AWS CloudWatch > 로그>로그그룹> /aws/containerinsights/<EKS명>/host (syslog)
- AWS CloudWatch > 로그>로그그룹> /aws/containerinsights/<EKS명>/performance (worker node resource)
4. Node 이슈 발생시 확인 방법 실습
- kubectl get nodes
- kubectl top node <Worker Node>
- kubectl describe node <Worker Node>
- 업데이트 문제 확인: AWS EKS Cluster > <Clsuter> > 구성 > 컴퓨팅 > 노드그룹 > <Node> > 상태 문제 , 업데이트 기록 확인

### CH09-04 POD 로깅 및 이슈 사례 조치방법
# cf, 환경구성후 테스트

3. POD 로깅 방법 실습
- POD 상태 확인: kubectl describe <pod 명>
- POD CPU, Memory: kubectl top pod <pod 명>
- POD 로그 확인: kubectl logs <pod 명>
- Container Insight를 통한 EKS POD 메트릭 모니터링 현황 확인
- Log Group을 통한 EKS POD 로그 수집 현황 확인: CloudWatch > /aws/containerinsights/<EKS>/application
- crictl을 통한 eks pod 현황 및 상태 확인 (EKS Worker Node SSH 접속)
4. POD 이슈 사례 발생시 확인 방법 실습
# POD CrashBackOff
- kubectl logs
# POD pending 
- kubectl describe <pod>
- kubectl top pod <pod>
# POD imagePullBackoff
- kubectl describe 
- Registry 로그인 정보를 Secret으로 등록 명령어
- kubectl create secret generic <Secret명> \
 --from-file=.dockerconfigjson=$HOME/.docker/config.json \
--type=kubernetes.io/dockerconfigjson
- Deployment에 Secret Mount 구문: spec.imagePullSecret.name 
# POD evicted
- kubectl describe <pod>
- kubectl top pod <pod>
- Container Insights