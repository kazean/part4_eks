# AWS EFS CSI Driver를 활용한 File Storage PV생성
# 실습 아키텍쳐
- READ, Write, Many (WorkerNode, POD)
1. EFS CSI Driver 설치
1-1. IAM Role 및 EKS내 서비스어카운트 생성(권한)
# 정책생성
curl -o iam-policy-example.json https://raw.githubusercontent.com/kubernetes-sigs/aws-efs-csi-driver/master/docs/iam-policy-example.json
aws iam create-policy \
    --policy-name AmazonEKS_EFS_CSI_Driver_Policy \
    --policy-document file://iam-policy-example.json
# 권한 생성
eksctl create iamserviceaccount \
--name efs-csi-controller-sa \
--namespace kube-system \
--cluster <EKS Cluster명> \
--attach-policy-arn arn:aws:iam::<AWS 계정>:policy/AmazonEKS_EFS_CSI_Driver_Policy \
--approve \
--override-existing-serviceaccounts \
--region ap-northeast-2

1-2. Helm 설치
curl -L https://git.io/get_helm.sh|bash -s -- --version v3.8.2
helm version
1-4. Helm 레포지토리 추가 (패키징이 특정 레포지토리에있음)
helm repo add aws-efs-csi-driver https://kubernetes-sigs.github.io/aws-efs-csi-driver/
1-5. Helm 레포지토리 업데이트
helm repo update

1-6. Helm Char로 AWS EFS CSI Driver 설치 
- Resource가 Chart형태, Char로 패키징을 설치한다.
helm upgrade -i aws-efs-csi-driver aws-efs-csi-driver/aws-efs-csi-driver \
--namespace kube-system \
--set image.repository=602401143452.dkr.ecr.ap-northeast-2.amazonaws.com/eks/aws-efs-csi-driver \
--set controller.serviceAccount.create=false \
--set controller.serviceAccount.name=efs-csi-controller-sa 
1-7 AWS EFS CSI Driver 설치 확인
kubectl get po -n kube-system | grep efs-csi-controller

2. Namespace구성, StorageClass 및 예제 PVC, POD 배포
2-1. Namespace
kubectl create ns test-csi-file-pv
2-2. StorageClass 배포 
kubectl create -f storageclass.yaml
2-3. POD, PVC 배포

3. File Storage PV 생성 및 볼륨 마운트 확인
3-1. PV, PVC 확인
kubectl get pv
kubectl get pvc -n test-csi-file-pv
3-2. 볼륨 마운트 확인
kubectl exec -it <pod> -n test-csi-file-pv -- df -h
kubectl exec -it <pod-1> -n test-csi-file-pv -- cat /dpod1/out
kubectl exec -it <pod-2> -n test-csi-file-pv -- cat /dpod2/out
3-3. pv efs 정보 확인
kubectl describe pv
- VolumeHandler 값 확인 (파일시스템ID:엑세스포인트ID)
3-4. AWS Console EFS 확인

4. 다른 워커노드에 있는 각 POD에서 Read,Write
4-1. POD 상태확인
4-2. 동시에 Read, Write
kubectl exec -it deploy-pod1 -n test-csi-file-pv -- bash -c 'echo "[deploy-pod1-message]" >> dpod1/out; tail -10 /dpod1/out'
kubectl exec -it deploy-pod2 -n test-csi-file-pv -- bash -c 'echo "[deploy-pod2-message]" >> dpod2/out; tail -10 /dpod2/out'

5. 2개의 POD 삭제 및 2개의 파드 생성 후 동시 읽기 수행
5-1. pod삭제
5-2. 볼륨보존확인
kubectl get pv 
AWS Console
5-3. 파드 재생성
5-4. 파일 동시 읽기 실행
kubectl exec -it deploy-pod1 -n test-csi-file-pv -- cat /dpod1/out
kubectl exec -it deploy-pod2 -n test-csi-file-pv -- cat /dpod2/out