#!/bin/bash
objects=$(curl -L https://raw.githubusercontent.com/nrkno/kubernetes-deprecations-checker/main/deprecations.json)
keys=($(echo $objects | jq 'keys[]'))
for key in "${keys[@]}"; do
    resources=$(echo $objects | jq -r .$key)
    resource_keys=($(echo $resources | jq 'keys[]'))

    for res in "${resource_keys[@]}"; do
        api_version=$(echo $resources | jq -r .$res)
        res=$(echo $res | xargs)
        echo -e "\v\t\a$(echo $key | xargs): Checking for $res of $api_version"
        kubectl get $(echo $res | xargs) -A -o json | jq -r --arg api_version "$api_version" --arg res "$res" '
            ["Resource", "Api Version", "Name", "Namespace"],
            (.items[] | select(.apiVersion == $api_version) | [$res, $api_version, .metadata.name, .metadata.namespace ])
            | @tsv
            ' | column -t -s $'\t'

    done
done