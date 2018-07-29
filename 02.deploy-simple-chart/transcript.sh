# lets deploy a chart ...
helm install stable/kubernetes-dashboard --name kubernetes-dashboard --set rbac.clusterAdminRole=true

# helm list - let's see what it has in store for us
helm ls --all kubernetes-dashboard
