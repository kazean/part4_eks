### velero 설치 및 소개
1. velero 소개
- Backup, migration tools
- backup, recovery, DR, back scheduling/retention, custom backup hook

# velero_policy.json
- ec2, efs .... > s3에 저장
- Resource: s3 test-velero-backup-bucket

2. velero설치
# (2)aws iam policy 생성
- aws iamcreate-policy --policy-name VeleroAccessPolicy --policydocument file://velero_policy.json 
# (3)aws iam role 생성
- kubectl create namespace velero
- eksctl create iamserviceaccount --cluster=<생성한EKS Cluster명> --name=velero-server --namespace=velero --role-name=eks-velerobackup --role-only --attach-policy-arn=arn:aws:iam::<AWS 계정ID(12자리수)>:policy/VeleroAccessPolicy --approve
# (4)Helm Chart로 설치를 위한 values.yaml 내용 확인
- initContainers(aws init container)
# configuration
- ~.provider: aws/azure,gcp
- ~.backupStorageLocation.bucket: test-velero-backup-bucket
- ~.backupStorageLocation.config.region: ap-northeast-2
- ~.volumeSnapshotLocation.name/config.region
- ~.serviceAccount.server.name/annotations //ServiceAccount를 통해 통신하기에 credential은 설정 안해도된다.
# (5)Helm Chart 배포
- helm install velero --namespace velero ./
# (6)Helm 배포 확인
- helm list -n velero
- kubectl get all -n velero
# (7)velero와 iam role 연동 확인
- kubectl get sa velero-server -n velero -o yaml
# (8)velero관리를 위환 CLI 설치
- brew install velero
- velero
