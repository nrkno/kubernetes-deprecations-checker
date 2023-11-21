#!/bin/bash
objects=$(cat deprecations.json)
keys=($(echo $objects | jq 'keys[]'))
for key in "${keys[@]}"; do
    # echo -e "\v\t\a\nChecking for deprecations from kubernetes version: $(echo $key | xargs)"
    resources=$(echo $objects | jq -r .$key)
    resource_keys=($(echo $resources | jq 'keys[]'))

    for res in "${resource_keys[@]}"; do
        api_version=$(echo $resources | jq -r .$res)
        res=$(echo $res | xargs)
        echo -e "\v\t\a$(echo $key | xargs): Checking for $res of $api_version"
        kubectl get $(echo $res | xargs) -A -o json | jq -r --arg api_version "$api_version" --arg res "$res" '
            ["Name", "Namespace", "Resource", "Api Version"],
            (.items[] | select(.apiVersion == $api_version) | [.metadata.name, .metadata.namespace, $res, $api_version])
            | @tsv
            ' | column -t -s $'\t' -c 2

    done
done