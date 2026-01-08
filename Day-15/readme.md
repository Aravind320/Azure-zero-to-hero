CD

1. Create a kubernetes cluster from console as azuredevops

2. After the creation of aks cluster, get the credentials in cli by using below command
    $az aks get-credentials --name azuredevops --overwrite-existing --resource-group azure-cicd1

3. Install ArgoCD from https://argo-cd.readthedocs.io/en/stable/getting_started/

4. Check the pods status by $kubectl get pods -n argocd

5. Get the credentials of argo cd
     $ kubectl get secrets -n argo cd

     $ kubectl edit secret argocd-initial-admin-secret  -n argocd
        copy the password and decode by
           $ echo <password> | base64 --decode

6. To login argocd from console we need to expose it node port from cluster
   $ kubectl get svc -n argocd
   $ kubectl edit svc argocd-server -n argocd
   and update the ip type from ClusterIP to NodePort

7. to get ip address
   $ kubectl get node -o wide
   take the external ip

   in url <external_ip>:NodePort (update the inbound traffic in vm scale sets, under instances - networking open the inbound traffic with port assigned in NodePort services)

8. Then you are able to open argocd
   userid: admin
   pass: which we decoded from secrets
