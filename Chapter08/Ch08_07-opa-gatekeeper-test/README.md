### CH08-07 OPA gatekeeper를 활용한 보안 정책관리 
1. Constraint Template, Constraint 코드 및 배포 
# Constrainttemplate
- kind: ConstraintTemplate
- spec.crd/targets
# Constraint
- ConstraintTemplate spec.crd.names.kind - Constraint kind와 매핑
# 배포
- kubectl apply -f ./ 
> template 배포후 constraint를 배포하여아함

2. Label 없이 pod 배포
- kubectl run nginx --image=nginx

3. 필요 Label 추가하여 pod 배포
- kubectl run nginx --image=nginx \
-l zone=ap-northeast-2,stage=test,status=ready
