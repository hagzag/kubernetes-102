#!/usr/bin/env bash

# Get admin token in order to connect via web
kubectl describe secrets kubernetes-dashboard-token | grep token: | awk '{print $2}'
