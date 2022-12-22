### [Ch06-07] velero backup
1. velero 설치 확인
- s3 bucket
- kubectl get po -n velero

2. Velero 백업 테스트 앱(Ghost) helm 배포 및 데이터 쓰기 수행
# values.yaml
- ~.mariadb ...
# (1)배포
- helm install ghost ./ --create-namespace --namespace ghost
# (2)백업 테스트앱 배포 후 도움말 중 추가 반영할 정보 확인
- export APP_HOST=$(kubectl get svc --namespace ghost ghost --template "{{ range (index .status.loadBalancer.ingress 0) }}{{ . }}{{ end }}"); echo "APP_HOST="$APP_HOST
- export GHOST_PW=$(kubectl get secret --namespace "ghost" ghost -o jsonpath="{.data.ghost-password}" | base64 --decode); echo "GHOST_PW="$GHOST_PW
- export DB_ROOT_PW=$(kubectl get secret --namespace "ghost" ghost-mariadb -o jsonpath="{.data.mariadbroot-password}" | base64 --decode); echo "DB_ROOT_PW="$DB_ROOT_PW
- export DB_PW=$(kubectl get secret --namespace "ghost" ghost-mariadb -o jsonpath="{.data.mariadbpassword}" | base64 --decode); echo "DB_PW="$DB_PW
# (3)백업 테스트앱 추가 반영정보 Upgrade
- helm upgrade ghost ./ --namespace ghost --set service.type=LoadBalancer --set ghostHost=$APP_HOST --set ghostPassword=$GHOST_PW--set mariadb.auth.rootPassword=$DB_ROOT_PW --set mariadb.auth.password=$DB_PW
# (4)배포후 Kubernetes Object 현황 확인
- kubectl get all -n ghost
- kubectl get pv
- kubectl get pvc -n ghost (RWO, AWS EBS 볼륨 확인)
# (5)ghost app dns 주소 확인
- kubectl get svc -n ghost
# (6)고스트 테스트앱 접속 주소
- admin: https://<dns>:80/ghost
- blog: https://<dns>:80
3. Velero backup 수행
# (1)velero 백업 저장소 확인 방법
- velero backup-location get
- velero backup-location get default -o yaml
# (2)velero 백업 수행
- velero backup create ghost-backup
# (3)velero 백업 결과 상세내용 확인방법
- velero backup logs ghost-backup
- velero backup describe ghost-backup [--details]

4. 백업 후 결과 확인

### [Ch06-07] velero restore
1. velero 복구 수행구조
- Restore Controller
2. 고스트 앱 삭제 (Helm Release, Namespace)
# (1) 고스트 앱 Helm  release 삭제 명령어
- helm uninstall ghost -n ghost
- helm list -n ghost
- kubectl get all -n ghost
# (2) namespace 삭제
- kubectl delete ns ghost
>> 볼륨은 삭제 되지만 스냅샷은 남아있음
# (3) 삭제후 namespace 내 파드 확인
3. velero 복구 수행
# (1) 복구 진행
- velero restore create ghost-restore --from-backup ghost-backup --include-namespaces ghost
# (2) 복구 결과 상세 확인법
- velero resotre logs ghost-restore
- velero restore describe ghost-restore
4. 복구후 결과 확인
# (1) namespace 및 Object 복구 확인
- kubectl get all -n ghost
- kubectl get pv 
- kubectl get pvc -n ghost
- helm list -n ghost
# (2) 복구된 테스트앱 접속을 위한 dns확인
# (3) velero 테스트앱 접속
