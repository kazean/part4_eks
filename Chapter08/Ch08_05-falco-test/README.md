### CH08-05 Falco를 활용한 런타임 보안강화 with FluentBit & Cloudwatch
1. CloudWatch 로그 수집을 위한 FluentBit 설치
# FluentBit Dir
- configmap.yaml
> data.fluent-bit.confg 
>> [INPUI] Tag: falco.*, Path: /var/log/containers/falco*.log
>> [OUTPUT] Name: cloudwatch, region
> parsers.conf
>   format: json
- daemonset.yaml (fluentBit daemonset형태)
- service-account: 전체 cluster에 적용 (kind: Cluster-Role)
# FluentBit 설치
- kubectl apply -f ./
> daemonset

2. 예제 Deploy 배포
> pods(3)

3. 보안 취약 상황 테스트 및 CloudWatch 로그확인
# 1. 특정 pod bash shell 접속
- kubectl exec -it <pod-name> -- bash
- kubectl log -f <falco>

# 2. 보안 정책 위배(취약점) 명령어 수행
- falco_rules.yaml
- 1) "Write below etc" > touch /etc/2
- 2)"Read sensitive file untrusted" > cat /etc/shadow > /dev/null 2>&1
- 3)"Mkdir binary dirs" > cd /bin & mkdir hello

4. CloudWatch Insights를 통한 쿼리 분석
- Error File below, Warning Sensitive file opened, Error Directory below known binary directory
- Logs Insight
- falco
- "Mkdri binary dirs" 로그 분석을 위한 쿼리 작성
fields @timestamp, @message
| filter @message like 'Mkdir binary dirs'
| sort @timestamp desc
- 쿼리 실행
- "Read sensitive file untrusted" 로그 분석을 위한 쿼리 작성
fields @timestamp, @message
| filter @message like 'Read sensitive file untrusted'
| sort @timestamp desc
- 쿼리 실행