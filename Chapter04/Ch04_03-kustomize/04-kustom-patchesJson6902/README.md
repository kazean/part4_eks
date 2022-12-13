# kustomize patchesJson6902
- kustomization.yaml
resources:
- deployment.yaml
patchesJson6902:
- target
    group:
    version:
    kind:
    name:
  path:

- replace.yaml
- op: add/replace/remove
path: ~
value : ~