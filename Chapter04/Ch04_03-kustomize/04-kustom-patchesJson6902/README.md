# kustomize patchesJson6902
- kustomization.yaml
resources:
- deployment.yaml
patchesJson6902:
- replace.yaml

- replace.yaml
- op: add/replace/remove
path: ~
value : ~