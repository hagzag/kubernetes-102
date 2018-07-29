Deploying a simple chart
========================
In `01.helm-installation` we used standard kubernetes manifests to deploy helm it-self to solve the **chicken & egg** situation ...
In this section we will deploy the `kubernetes-dashboard` project via `helm`.

1. Using the official `helm-charts` repo doesn't require any special setup so we can deploy simply by executing:

  `helm install stable/kubernetes-dashboard --name kubernetes-dashboard --set rbac.clusterAdminRole=true`

  **note** using the --set value will override the default value defined in the chart `stable/kubernetes-dashboard`

2. Chart output:

   A *well documented chart* will also return back to the user what he just deployed and how to access it once it's complete like in our example:

```
RESOURCES:
==> v1/Service
NAME                  TYPE       CLUSTER-IP     EXTERNAL-IP  PORT(S)  AGE
kubernetes-dashboard  ClusterIP  100.65.253.63  <none>       443/TCP  2s

==> v1beta1/Deployment
NAME                  DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
kubernetes-dashboard  1        1        1           0          1s

==> v1/Pod(related)
NAME                                   READY  STATUS             RESTARTS  AGE
kubernetes-dashboard-7697b4475c-54wzt  0/1    ContainerCreating  0         1s

==> v1/Secret
NAME                  TYPE    DATA  AGE
kubernetes-dashboard  Opaque  0     2s

==> v1/ServiceAccount
NAME                  SECRETS  AGE
kubernetes-dashboard  1        2s

==> v1beta1/ClusterRoleBinding
NAME                  AGE
kubernetes-dashboard  2s


NOTES:
*********************************************************************************
*** PLEASE BE PATIENT: kubernetes-dashboard may take a few minutes to install ***
*********************************************************************************

Get the Kubernetes Dashboard URL by running:
export POD_NAME=$(kubectl get pods -n kube-system -l "app=kubernetes-dashboard,release=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
echo https://127.0.0.1:8443/
kubectl -n kube-system port-forward $POD_NAME 8443:8443
```

3. Access the dashboard:

  As instructed above in the chart's well documented output ->
  ```
  export POD_NAME=$(kubectl get pods -n kube-system -l "app=kubernetes-dashboard,release=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}")
  echo https://127.0.0.1:8443/
  kubectl -n kube-system port-forward $POD_NAME 8443:8443
  ```

  This basically does the following:
  - Get the pod name via `kubectl` like so:

    `kubectl get pods -n kube-system -l "app=kubernetes-dashboard,release=kubernetes-dashboard" -o jsonpath="{.items[0].metadata.name}"`
  - Then `port-forward` `8443` on your local machine to the `8443` on the `pod` like os:

    `kubectl -n kube-system port-forward $POD_NAME 8443:8443`


4. If you are now curious use your web browser to see the Dashboard.

    Please note in order to access it you could use your `kubctl` which requires some setup or alternatively use the `kubectl describe secrets kubernetes-dashboard-token` command to get the admin access `token` and just use that.

    In our example the value returned from this command would be:

    ```yaml
    $ kubectl describe secrets kubernetes-dashboard-token

    Name:         kubernetes-dashboard-token-fr8g7
    Namespace:    kube-system
    Labels:       <none>
    Annotations:  kubernetes.io/service-account.name=kubernetes-dashboard
                  kubernetes.io/service-account.uid=6a47d216-92b8-11e8-9e4e-0ae758f37828

    Type:  kubernetes.io/service-account-token

    Data
    ====
    ca.crt:     1042 bytes
    namespace:  11 bytes
    token:      eyJhbGciOiJSSCRAMBLEDcCI6IkpXVCJ9.eyJpcSCRAMBLEDWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJrdWJlcm5ldGVzLWRhc2hib2FyZC10b2tlbi1mcjhnNyIsImSCRAMBLEDZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJrdWJlcm5lSCRAMBLEDSCRAMBLEDmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjZhNDdkMjE2LTkyYjgtMTFlOC05ZTRlLTBhZTc1OGYzNzgyOCIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTprdWJlcm5ldGVzLWRhc2hib2FyZCJ9.n7qlg02czKur3fSk8GBYcBcKp2Ap9IxcaO3Gxx_74fmsFcSnxUiZ2IYXCbEGnsD_rV5h4Dr2VuyoO0s3LAHiUUvTaKvFPSY7A3BWUw0fGva6XSCRAMBLEDuNYoGFT7gZgMgNSlS_dFYnXlZg-riSCRAMBLEDWdbK5oidqjW1KHWhJhvFik61N7v8JGgmNqAVMOwLdpCbTmHduBr-qW0TK0tLt5omZgY_jkgVpqbMgLajPXq5OziK110CZSCRAMBLEDKWsyRKhV3TbOik13HpLTrCqwH7YdAriIawrAM9sBhEPP6LiN1_v8f7fHmaOJ6-yVYEKlg
    ```
  Just copy the token to your clipboard and use it in the ui via http://127.0.0.1:8443

5. Cleanup

   You can use the `./cleanup.sh` supplied here-in it basically does the following:
   - remove any port-forwarding which may be done in the background
   - `helm del --purge kubernetes-dashboard`


**In the next chapter we will review charts and ways to build them ...**
