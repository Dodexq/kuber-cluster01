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

#

## GitLab
1. create namespace `kubectl create ns gitlab `
2. install helm app `helm install gitlab -n gitlab ./gitlab`
3. apply ingress web && ssh `kubectl apply ./helm-chart/gitlab/cluster/ingress-gitlab.yaml && kubectl apply ingress-nginx-tcp.yaml` 

<p align="center"> 
<a href="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/gitlab-commit.png" rel="some text"><img src="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/gitlab-commit.png" alt="" width="500" /></a>
</p>

#

## Monitoring
1. `kubectl create ns monitoring`
2. `helm install loki -n monitoring loki-stack/ --set loki.persistence.enabled=true`

#

## Minio S3 on docker-compose
1. configure Vagrantfile: `server.vm.disk :disk, size: "40GB", name: "extra_storage"`
2. exec `VAGRANT_EXPERIMENTAL=disks vagrant up`
3. use `fdisk /dev/sdb` create 1 default full partition
4. create volume group: `pvcreate /dev/sdb1` && `vgcreate s3vg /dev/sdb1` display lvm vg: `vgdisplay s3vg`
5. create logical volume: `sudo lvcreate -l 100%FREE -n s3lv s3vg` display lvm lv: `lvs`
6. create file system: `mkfs.xfs /dev/mapper/s3vg-s3lv`
7. create s3 folder: `mkdir /s3` && `chmod 777 /s3`
8. configure automount: `nano /etc/fstab` append `/dev/mapper/s3vg-s3lv /s3 xfs defaults,nofail 0 0` and `mount -a` display all Filesystems: `df -h`
9. minio install `cd /s3/minio` && `mkdir data1-1 data1-2 data2-1 data2-2 data3-1 data3-2 data4-1 data4-2`
10. `chmod -R 777 data1-1 data1-2 data2-1 data2-2 data3-1 data3-2 data4-1 data4-2`
11. exec `cd ./minio/docker/` && `docker-compose`

#

<p align="center"> 
<a href="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/minio_test.png" rel="some text"><img src="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/minio_test.png" alt="" width="500" /></a>
</p>

#

## Minio S3 in Gitlab helm-chart
1. add `./helm-chart/gitlab/values.yaml`
```
minio:
    enabled: true
    credentials:
      secret: gitlab-minio-secret
```
2. check config `kubectl exec -it pod/gitlab-toolbox-xxxxxxxxxx-xxxxx -n gitlab -- cat /home/git/.s3cfg`
3. add ingress url balancing `./helm-chart/gitlab/cluster/`
```
  - host: minio.dodex.site
    http:
      paths:
      - pathType: Prefix
        path: /
        backend:
          service:
            name: gitlab-minio-svc
            port:
              number: 9000
```
#

<p align="center"> 
<a href="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/minio_test_gitlab.png" rel="some text"><img src="https://raw.githubusercontent.com/Dodexq/kuber-cluster01/main/screenshots/minio_test_gitlab.png" alt="" width="500" /></a>
</p>

#

## Connect Minio Client (mc)
1. download mc `wget https://dl.min.io/client/mc/release/linux-amd64/mc`
2. allow exec `chmod +x mc` && `mv ./mc /usr/local/bin/`
3. configure mc `mc config host add minio http://127.0.0.1:9000 admin Gst4Kuber% --api S3v4`
4. check backend connect `mc admin trace -v -a --json minio`

#

## Docker images
https://hub.docker.com/u/dodexq