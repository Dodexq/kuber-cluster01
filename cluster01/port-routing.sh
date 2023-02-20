#!/bin/bash
sudo iptables -t nat -A POSTROUTING -t nat -p tcp -m tcp -s 172.18.0.100 --sport 80 -j SNAT --to-source 0.0.0.0
sudo iptables -A FORWARD -m state -p tcp -d 172.18.0.100 --dport 80 --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -A PREROUTING -p tcp --dport 1080 -j DNAT --to-destination 172.18.0.100:80

sudo iptables -t nat -A POSTROUTING -t nat -p tcp -m tcp -s 172.18.0.100 --sport 443 -j SNAT --to-source 0.0.0.0
sudo iptables -A FORWARD -m state -p tcp -d 172.18.0.100 --dport 443 --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -A PREROUTING -p tcp --dport 10443 -j DNAT --to-destination 172.18.0.100:443