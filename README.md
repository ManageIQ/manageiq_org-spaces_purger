###Build
```bash
docker build --no-cache -t docker.io/manageiq/manageiq_org-spaces_purger:latest .
```

###Deploy
```bash
kubectl create secret generic spaces-secrets --from-literal=key=<YOUR_ACCESS_KEY> --from-literal=secret=<YOUR_SECRET>
kubectl create -f cronjob.yaml
```
