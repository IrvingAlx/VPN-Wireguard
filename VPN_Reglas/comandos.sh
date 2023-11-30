#!/bin/bash

docker exec -it wireguard iptables -F
docker exec -it wireguard iptables -P INPUT DROP
docker exec -it wireguard iptables -P FORWARD DROP
docker exec -it wireguard iptables -P OUTPUT DROP

docker exec -it wireguard iptables -A INPUT -i lo -j ACCEPT
docker exec -it wireguard iptables -A OUTPUT -o lo -j ACCEPT

docker exec -it wireguard iptables -A INPUT -i wg0 -j ACCEPT
docker exec -it wireguard iptables -A OUTPUT -o wg0 -j ACCEPT

docker exec -it wireguard iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

docker exec -it wireguard iptables -A OUTPUT -p tcp -d localhost --dport 80 -j ACCEPT

docker exec -it wireguard iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
docker exec -it wireguard iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

docker cp html/index.html wireguard:/usr/share/nginx/html/index.html
