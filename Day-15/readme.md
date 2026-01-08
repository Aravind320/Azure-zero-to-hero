CD

1. Create a kubernetes cluster from console as azuredevops

2. After the creation of aks cluster, get the credentials in cli by using below command
    $az aks get-credentials --name azuredevops --overwrite-existing --resource-group azure-cicd1

3. Install ArgoCD from https://argo-cd.readthedocs.io/en/stable/getting_started/

4. Check the pods status by $kubectl get pods -n argocd
