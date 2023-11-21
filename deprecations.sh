#!/bin/bash
objects=$(cat objects.json)
keys=($(echo $objects | jq 'keys[]'))
for key in "${keys[@]}"; do
    echo -e "\v\t\a\nChecking for deprecations from kubernetes version: $(echo $key | xargs)"
    resources=$(echo $objects | jq -r .$key)
    resource_keys=($(echo $resources | jq 'keys[]'))

    for res in "${resource_keys[@]}"; do
        api_version=$(echo $resources | jq -r .$res)
        echo -e "\v\t\a$(echo $key | xargs): Checking for $(echo $res | xargs) of $api_version"
        kubectl get $(echo $res | xargs) -A -o json | jq -r '.items[] | select(.apiVersion == "'"$api_version"'") | "\(.metadata.name)\t\(.metadata.namespace)"' | column -t -s $'\t'
    done
done