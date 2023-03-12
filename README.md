# Kubernates Kind Cluster with Metallb, Ingress LoadBalancer, Cert-manager, Helm-Charts and etc.
 

## Basic installation
1) exec sh cluster_run: `./cluster01/cluster-run.sh`
2) apply Calico: `kubectl apply -f ./cluster01/calico-3.25.yaml`
3) apply Metallb: `kubectl apply -f ./cluster01/metallb/metallb-native.yaml`
4) apply `kubectl apply -f ./cluster01/metallb/metallb-new-config.yaml` after configure ip addr (pool can be see use sh: `./cluster01/metallb/get_docker_network.sh`)
5) apply ingress-controller `kubectl apply -f ./cluster01/ingress-deploy.yaml`
6) apply cert-manager `kubectl apply -f ./cluster01/cert-manager/cert-manager.yaml` 
7) apply in folder `./cluster01/cert-manager/acme-prod.yaml` & `./cluster01/cert-manager/acme-staging.yaml` - (ClusterIssuer)
8) apply foo/bar ingress url loadbalancer `kubectl apply -f ./cluster01/ingress-deployment-host-tls.yaml`
9) apply argocd ingress svc `kubectl apply -f ./cluster01/ingress-argocd_svc.yaml`

#

<p align="center"> 
<a href="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/cluster01.png" rel="some text"><img src="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/cluster01.png" alt="" width="500" /></a>
</p>

#

<p align="center"> 
<a href="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/host_foo.png" rel="some text"><img src="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/host_foo.png" alt="" width="500" /></a>
</p>

#

<p align="center"> 
<a href="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/argocd_screen01.png" rel="some text"><img src="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/argocd_screen01.png" alt="" width="500" /></a>
</p>

## Helm Charts (Resume, GitLab)
1) `kubectl create ns gitlab `
2) `helm install gitlab -n gitlab ./gitlab`
## Monitoring
1) `kubectl create ns monitoring`
2) `helm install loki -n monitoring loki-stack/ --set loki.persistence.enabled=true`

