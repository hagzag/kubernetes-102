#!/usr/bin/env bash
echo "See how we ovveride values by using --set ..."

helm install stable/kubernetes-dashboard \
             --name kubernetes-dashboard \
             --set rbac.clusterAdminRole=true
