# Cluster Autoscalier를 활용한 eks node auto scaling
1. AWS Autoscaling Group내 태그 설정
- k8s.io/cluster-autoscaler/<EKS Cluster명> : owned
- k8s.io/cluster-autoscaler/enabled  : true
- node 최대수 : 6

2. Terraform으로 IAM Policy 적용
- iam-policy.tf
autoscaling Policy

3. eksctl로 IAM Role 및 서비스 어카운트 생성
eksctl create iamserviceaccount \
--name cluster-autoscaler \
--namespace kube-system \
--cluster <EKS Cluster명> \
--attach-policy-arn arn:aws:iam::<AWS계정ID>: policy/<EFS IAM Policy명> \
--approve \
--override-existing-serviceaccounts \
--region ap-northeast-2
> cluster-autoscaler -n kube-system

4. Cluster 배포 및 설정
kubetl create -f cluster-autoscaler.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole

apiVersion: rbac.authorization.k8s.io/v1
kind: Role

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding

apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding

apiVersion: apps/v1
kind: Deployment
    containers: 
        command:
            - --node-group-auto-discovery=asg:tag=k8s.io/cluster-autoscaler/enabled,k8s.io/cluster-autoscaler/<EKS Cluster명>

5. 10개 Pod 배포 및 EKS Worker Node 작동 Scale-out
kubectl create ns test-ca
kubectl create -f deploy-pod.yaml

6. pod 2개로 scale-in
node까지 회수(10분, 가장 오래된 자원부터 회수)