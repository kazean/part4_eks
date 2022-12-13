# kustomize Manifest
- kustomizaion.yaml
resources:
- deployment.yaml
- service.yaml

kubectl kustomize <kustomnization dir>
kubectl apply -k/--kustomize <dir>
kubectl delete -k <dir>