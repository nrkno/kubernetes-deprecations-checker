# Simple shell script to check for deprecations in your kubernetes cluster
Starting at kubernetes version 1.25.
Manual updates to `deprecations.json` is needed when new kubernetes deprecations are announced.

## Dependencies:
```
kubectl
jq
xargs
```

## Usage:
```bash
chmod +x deprecations.sh
./deprecations.sh
```