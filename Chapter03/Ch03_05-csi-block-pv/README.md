#AWS EBS CSI Driver 활용한 Block Storage PV 생성
0. 사전준비사항
- ingress alb와 같음 (기존환경)

1. AWS EBS CSI Driver 설치
- IAM Policy를 Terraform으로 생성 iam-policy.tf
policy = jsonencode(~) 설정
$ terraform init/plan/apply
- IAM Role 및 EKS내 서비스 어카운트 생성 (OIDC)
$ eksctl create iamserviceaccount \
--name ebs-csi-controller-sa \
--namespace kube-system \
--cluster <EKS Cluster명> \
--attach-policy-arn arn:aws:iam::<AWS계정ID>:policy/<EBS_CSI_Driver_Policy명> \
--approve \
--override-existing-serviceaccounts
> AWS POliCY에 해당하는 것을 kubernetes안에 권한있는 계정생성
- cloud formation에서 수행된 결과값 확인 명령어
$ aws cloudformation describe-stacks \ 
--stack-name eksctl-<EKS Cluster명>-addoniamserviceaccount-kube-system-ebs-csi-controller-sa \
--query='Stacks[].Outputs[?OutputKey==`Role1`].OutputValue' \
--output text
> (결과값) arn:aws:iam::<AWS 계정ID>:role/eksctl-<EKS Cluster명>-addon-iamserviceaccountkube-sy-Role1-<1J7XB63IN3L6T ‒할당된ID>
- EBS CSI Driver Manifest 배포
$ kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csidriver/deploy/kubernetes/overlays/stable/ecr/?ref=master" 
(pod ebs-csi-controller / node)
- 배포 후 서비스 어카운트 annotation 반영 명령어
$ kubectl get sa -n kube-system
$ kubectl get sa ebs-csi-controller-sa -o yaml -n kube-system 어노테이션 등록확인
!> 등록 안되있을 경우 수동 등록 후 restart
$ kubectl annotate serviceaccount ebs-csi-controller-sa \
-n kube-system \
eks.amazonaws.com/role-arn=arn:aws:iam::<AWS 계정ID>:role/eksctl-<EKS Cluster명>-addon-iamserviceaccount-kube-sy-Role1- <1J7XB63IN3L6T ‒할당된ID>

2. namespace구성, 예제 Deployment배포, Block Storage PV 생성
- namespace 생성
$ kubectl create namespace test-csi-block-pv
-  test-csi-block-pv-pod 
containers:
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
$ kubectl create -f . -n test-csi-block-pv
$ kubectl get po/pvc/sc/pv -n test-csi-block-pv

3. Block Storage 자동생성 확인 및 볼륨 마운트 확인 
- PV 생성 확인
AWS Management Console > EC2 > Elastic Block Store >볼륨

$ kubectl get pv
$ kubectl get pvc ‒n test-csi-block-pv
$ kubectl describe po app -n test-csi-block-pv
Containers
  Mouts
Volumes:
  peresistent-storage:
Events:
    ~~ AttachVolume

$ kubectl describe pv <PV명>
>VolumeHandle값확인

-볼륨 마운트 확인
$ kubectl exec ‒it <POD명> -n test-csi-block-pv -- df ‒h
$ kubectl exec ‒it <POD명> -n test-csi-block-pv -- cat /data/out.txt

4. 데이터/파일 쓰기 및 POD 삭제 후  볼륨 보존 확인
- 4.1데이터/파일쓰기
$ kubectl get ‒it <POD명> -n test-csi-block-pv -- echo "First data" >> /data/out.txt
$ kubectl get ‒it <POD명> -n test-csi-block-pv -- echo "Second data" >> /data/out.txt
- 4.2 POD 삭제
$ kubectl delete po <POD명> -n test-csi-block-pv
- 4.3 볼륨보존확인
$ kubectl get pv
- AWS 확인경로: AWS Management Console > EC2 > Elastic Block Store >볼륨

5. POD재생성 후 자동 볼륨 마운트 확인 및 데이터/파일 읽기 확인
- 5.1 POD 재생성
$ kubectl create ‒f test-csi-block-pv-pod.yaml
- 5.2 자동볼륨마운트확인
$ kubectl get ‒it <POD명> -n test-csi-block-pv -- df ‒h
- 5.3 데이터/파일읽기확인
$ kubectl get ‒it <POD명> -n test-csi-block-pv -- cat /data/out.txt
First및Second data존재확인