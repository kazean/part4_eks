### Custom Resource Definition 소개
1. Custom Resource
2. Custom Resource Definition
3. CRD 생성
- kind: CustomResourceDefinition
- spec.group/version/scopde/name
# CRD 생성
- kubectl apply -f <crd>.yaml
- kubectl get crd
- kubectl explain <kind>
4. CR 생성
- apiVersion: group.version
- kind: <kind>
# CR 생성
- kubectl apply -f <cr>.yaml
- kubectl get <kind>
- kubectl get <kind> <name>
> Object 껍데기일뿐, 특정 작동 및 스케줄링 등을 자동화하기 위한 것이 Operator