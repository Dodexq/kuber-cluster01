# Kubernates Kind Cluster with Metallb, Ingress LoadBalancer, Cert-manager, Helm-Charts and etc.
 

## Basic installation
1. exec sh cluster_run: `./cluster01/cluster-run.sh`
2. apply Calico: `kubectl apply -f ./cluster01/calico-3.25.yaml`
3. apply Metallb: `kubectl apply -f ./cluster01/metallb/metallb-native.yaml`
4. apply `kubectl apply -f ./cluster01/metallb/metallb-new-config.yaml` after configure ip addr (pool can be see use sh: `./cluster01/metallb/get_docker_network.sh`)
5. apply ingress-controller `kubectl apply -f ./cluster01/ingress-deploy.yaml`
6. apply cert-manager `kubectl apply -f ./cluster01/cert-manager/cert-manager.yaml` 
7. apply in folder `./cluster01/cert-manager/acme-prod.yaml` & `./cluster01/cert-manager/acme-staging.yaml` - (ClusterIssuer)
8. apply foo/bar ingress url loadbalancer `kubectl apply -f ./cluster01/ingress-deployment-host-tls.yaml`
9. apply argocd ingress svc `kubectl apply -f ./cluster01/ingress-argocd_svc.yaml`

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
1. `kubectl create ns gitlab `
2. `helm install gitlab -n gitlab ./gitlab`
## Monitoring
1. `kubectl create ns monitoring`
2. `helm install loki -n monitoring loki-stack/ --set loki.persistence.enabled=true`
## Minio S3
1. configure Vagrantfile: `server.vm.disk :disk, size: "40GB", name: "extra_storage"`
2. exec `VAGRANT_EXPERIMENTAL=disks vagrant up`
3. use `fdisk /dev/sdb` create 1 default full partition
4. create volume group: `pvcreate /dev/sdb1` && `vgcreate s3vg /dev/sdb1` display lvm vg: `vgdisplay s3vg`
5. create logical volume: `sudo lvcreate -l 100%FREE -n s3lv s3vg` display lvm lv: `lvs`
6. create file system: `mkfs.xfs /dev/mapper/s3vg-s3lv`
7. create s3 folder: `mkdir /s3` && `chmod 777 /s3`
8. configure automount: `nano /etc/fstab` append `/dev/mapper/s3vg-s3lv /s3 xfs defaults,nofail 0 0` and `mount -a` display all Filesystems: `df -h`

## Docker images
https://hub.docker.com/u/dodexq