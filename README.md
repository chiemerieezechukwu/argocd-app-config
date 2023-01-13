# ArgoCD Apps

```zsh
kubectl create secret generic awssm-secret \
--from-literal access-key=<ACCESS_KEY_ID> \
--from-literal secret-access-key=<SECRET_ACCESS_KEY> \
-n <NAMESPACE>
```

```zsh
kubectl -n argocd create secret generic argo-github-secret --from-literal=dex.github.clientSecret=<GitHubClientSecret>
```

> Note that the label `app.kubernetes.io/part-of: argocd` needs to be added to the above secret after creation.
See https://argo-cd.readthedocs.io/en/stable/operator-manual/user-management/#alternative
