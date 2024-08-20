# Simple shell script to check for deprecations in your kubernetes cluster
Starting at kubernetes version 1.25.
Manual updates to `deprecations.json` is needed when new kubernetes deprecations are announced.

## Usage
```bash
curl -sL https://raw.githubusercontent.com/nrkno/kubernetes-deprecations-checker/main/deprecations.sh | bash
```
 or
```bash
chmod +x deprecations.sh
./deprecations.sh
```

## Dependencies:
```
kubectl
jq
xargs
```
