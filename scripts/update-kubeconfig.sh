#!/bin/bash
response="$(aws eks list-clusters --region us-east-2 --output text | grep -i dominion-cluster1 2>&1)" 
if [[ $? -eq 0 ]]; then
    echo "Success: Dominion-cluster1 exist"
    aws eks --region us-east-2 update-kubeconfig --name dominion-cluster1 && export KUBE_CONFIG_PATH=~/.kube/config

else
    echo "Error: Dominion-cluster1 does not exist"
fi