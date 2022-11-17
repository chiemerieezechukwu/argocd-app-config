```
kubectl create secret generic awssm-secret \
--from-literal access-key=<ACCESS_KEY_ID> \
--from-literal secret-access-key=<SECRET_ACCESS_KEY> \
-n <NAMESPACE>
```