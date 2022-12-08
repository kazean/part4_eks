#AWS EBS CSI Driver 활용한 Block Storage PV 생성
0. 사전준비사항
- ingress alb와 같음 (기존환경)

# 
1. AWS EBS CSI Driver 설치
 terraform init/plan/apply 

# as-is
- IAM Policy를 Terraform으로 생성 iam-policy.tf
policy = jsonencode(~) 설정
-eksctl
- eksctl ALB Controller 설치
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin


1-1. IAM Role 및 EKS내 서비스 어카운트 생성 (OIDC)
eksctl create iamserviceaccount \
--name ebs-csi-controller-sa \
--namespace kube-system \
--cluster <EKS Cluster명> \
--attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
--approve \
--role-only \
--role-name Amazon_EKS_EBS_CSI_DriverRole
> AWS POliCY에 해당하는 것을 kubernetes안에 권한있는 계정생성
- cloud formation에서 수행된 결과값 확인 명령어

# as-is
 eksctl create iamserviceaccount \
--name ebs-csi-controller-sa \
--namespace kube-system \
--cluster <EKS Cluster명> \
--attach-policy-arn arn:aws:iam::<AWS계정ID>:policy/<EBS_CSI_Driver_Policy명> \
--approve \
--override-existing-serviceaccounts
 aws cloudformation describe-stacks \ 
--stack-name eksctl-<EKS Cluster명>-addoniamserviceaccount-kube-system-ebs-csi-controller-sa \
--query='Stacks[].Outputs[?OutputKey==`Role1`].OutputValue' \
--output text
> (결과값) arn:aws:iam::<AWS 계정ID>:role/eksctl-<EKS Cluster명>-addon-iamserviceaccountkube-sy-Role1-<1J7XB63IN3L6T ‒할당된ID>

1-2. eksctl 애드온을 통한 설치
eksctl create addon --name aws-ebs-csi-driver --cluster <EKS Cluster명> --service-account-role-arn arn:aws:iam::<AWS계정ID>:role/Amazon_EKS_EBS_CSI_DriverRole --force
1-3. eksctl 애드온을 통한 설치상태 확인
eksctl get addon --name aws-ebs-csi-driver --cluster <EKS Cluster명>
1-4. AWS EBS CSI Driver 설치 확인
kubectl get pod -n kube-system | grep ebs-csi-controller

# as-is
- EBS CSI Driver Manifest 배포
 kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csidriver/deploy/kubernetes/overlays/stable/ecr/?ref=master" 
(pod ebs-csi-controller / node)
- 배포 후 서비스 어카운트 annotation 반영 명령어
 kubectl get sa -n kube-system
 kubectl get sa ebs-csi-controller-sa -o yaml -n kube-system 어노테이션 등록확인
!> 등록 안되있을 경우 수동 등록 후 restart  
 kubectl annotate serviceaccount ebs-csi-controller-sa \
-n kube-system \
eks.amazonaws.com/role-arn=arn:aws:iam::<AWS 계정ID>:role/eksctl-<EKS Cluster명>-addon-iamserviceaccount-kube-sy-Role1- <1J7XB63IN3L6T ‒할당된ID>

# 
2. namespace구성, 예제 Deployment배포, Block Storage PV 생성
- namespace 생성
 kubectl create namespace test-csi-block-pv
-  test-csi-block-pv-pod 
containers:
  volumeMounts:
    - name: persistent-storage
      mountPath: /data
volumes:
- name: persistent-storage
  persistentVolumeClaim:
    claimName: ebs-claim
- test-csi-block-pv-pvc.yaml

kind: PersistentVolumeClaim
metadata:
  name: ebs-claim
spec:
  accessModes:
    - ReadWriteOnce #RWO ebs 특성
  storageClassName: ebs-sc #Storage class 어떠한 형태의 스토리지 
  resources:
    requests:
      storage: 4Gi #용량 설정
- test-csi-block-pv-sc.yaml (Storage class)
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: ebs-sc
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer # 볼륨을 생성해서 바인딩 하기 위해선 자원이 있어야함(Pod)
- 배포
 kubectl create -f . -n test-csi-block-pv
 kubectl get po/pvc/sc/pv -n test-csi-block-pv

# 
3. Block Storage 자동생성 확인 및 볼륨 마운트 확인 
- PV 생성 확인
AWS Management Console > EC2 > Elastic Block Store >볼륨

kubectl get pv
kubectl get pvc ‒n test-csi-block-pv
kubectl describe po app -n test-csi-block-pv
[CSI-BLOCK-PV-POD]
Containers
  Mouts
Volumes:
  peresistent-storage:
Events:
    ~~ AttachVolume

 kubectl describe pv <PV명>
>VolumeHandle값확인

-볼륨 마운트 확인
 kubectl exec ‒it <POD명> -n test-csi-block-pv -- df ‒h
 kubectl exec ‒it <POD명> -n test-csi-block-pv -- cat /data/out.txt

# 
4. 데이터/파일 쓰기 및 POD 삭제 후  볼륨 보존 확인
- 4.1데이터/파일쓰기
 kubectl exec ‒it <POD명> -n test-csi-block-pv -- sh -c 'echo "First data" >> /data/out.txt'
 kubectl exec ‒it <POD명> -n test-csi-block-pv -- sh -c 'echo "Second data" >> /data/out.txt'
- 4.2 POD 삭제
 kubectl delete po <POD명> -n test-csi-block-pv
- 4.3 볼륨보존확인
 kubectl get pv
- AWS 확인경로: AWS Management Console > EC2 > Elastic Block Store >볼륨

#
5. POD재생성 후 자동 볼륨 마운트 확인 및 데이터/파일 읽기 확인
- 5.1 POD 재생성
 kubectl create ‒f test-csi-block-pv-pod.yaml
- 5.2 자동볼륨마운트확인
 kubectl get ‒it <POD명> -n test-csi-block-pv -- df ‒h
- 5.3 데이터/파일읽기확인
 kubectl get ‒it <POD명> -n test-csi-block-pv -- cat /data/out.txt
First및Second data존재확인

# 추가내용
1. Persistent Volume Mount 및 Volume Attach 검증 #1
- POD에서 사용되는 PV는 EKS Worker Node기준으로 Volume을 Attach한 후, Node에 스케줄링 된 Pod에 Volume을 파일시스템에 Mount해서 사용하는 것이다.

2. Persistent Volume Mount 및 Volume Attach 검증 #2
- Pod, PVC, PV, Node현황 확인

3. Persistent Volume Mount 및 Volume Attach 검증 #3
- Pod에 Mount된 Volume 상세현황 확인
kubectl get po -o yaml | grep -C5 vol
kubectl describe po 

5. Persistent Volume Mount 및 Volume Attach 검증 #5
- PVC 상세내역 확인 (Workernode)
kubectl describe pvc

6. Persistent Volume Mount 및 Volume Attach 검증 #6
- PV 상세내역 확인 (볼륨ID, EC2 EBS Volume 정보확인)
kubectl describe pv

7. Persistent Volume Mount 및 Volume Attach 검증 #7
- EBS 볼륨 상세내역 확인 (6번과 비교)

8. Persistent Volume Mount 및 Volume Attach 검증 #8
-  EC2 VM 상세내역 확인 (5번 Workernode와 비교)

9. Persistent Volume Mount 및 Volume Attach 검증 #9
- (가설) POD를 Restart를 하면 다른 workernod에 할당될 것이다?
kubectl rollout restart deploy 
>> but, 동일한 노드로만 스케줄링 된다

11. Persistent Volume Mount 및 Volume Attach 검증 #11
- (가설) POD가 실행중이고 PV가 Attach된 Worker Node에 스케줄링을 막으면?
kubectl cordon <Pod가 기동중이 node명>

>> Pod pending > 다른 node로 scheduling 되지만, PV가 mount가 되지 않기에 정상기동이 되지 않는다
14. Persistent Volume Mount 및 Volume Attach 검증 #14
- cordon된 node를 다시 uncordon 한다면?
kubectl uncordon 
>> Attach된 Node에만 스케줄링 될 수 있다




