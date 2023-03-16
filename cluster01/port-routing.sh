#!/bin/bash
## Ingress Controller
sudo iptables -t nat -A PREROUTING -p tcp --dport 1080 -j DNAT --to-destination 172.18.0.100:80
sudo iptables -p tcp -A FORWARD -d 172.18.0.100 --dport 80 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -t nat -p tcp -m tcp -s 172.18.0.100 --sport 80 -j SNAT --to-source 0.0.0.0

sudo iptables -t nat -A PREROUTING -p tcp --dport 10443 -j DNAT --to-destination 172.18.0.100:443
sudo iptables -p tcp -A FORWARD -d 172.18.0.100 --dport 443 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -t nat -p tcp -m tcp -s 172.18.0.100 --sport 443 -j SNAT --to-source 0.0.0.0

## Minio
sudo iptables -t nat -A PREROUTING -p tcp --dport 9000 -j DNAT --to-destination 172.19.0.5:9000
sudo iptables -p tcp -A FORWARD -d 172.19.0.5 --dport 9000 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -t nat -p tcp -m tcp -s 172.19.0.5 --sport 9000 -j SNAT --to-source 0.0.0.0

sudo iptables -t nat -A PREROUTING -p tcp --dport 9001 -j DNAT --to-destination 172.19.0.5:9001
sudo iptables -p tcp -A FORWARD -d 172.19.0.5 --dport 9001 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -t nat -p tcp -m tcp -s 172.19.0.5 --sport 9001 -j SNAT --to-source 0.0.0.0