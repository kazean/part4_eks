# kustomize base/overlay
1. base
- kustomization.yaml
resource:
- ~Object.yaml

2. dev
- kustomization.yaml
bases:
- ../base
namePrefix: dev-

3. prod
- dev와 같음 
namePrefix: prod-