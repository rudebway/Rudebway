#!/usr/bin/env bash
#sudo ip addr add 192.168.100.128/24 dev enp2s0
#ssh-keygen -f "/root/.ssh/known_hosts" -R 192.168.100.100
#ssh-keyscan -H 192.168.100.100 >>/root/.ssh/known_hosts
while true
do
date >> result.log
sshpass -p 'Fx566434' ssh admin@`IIIIPPPPP` 'echo moLD02p | sudo -S `-----`' >> result.log
echo "__________________________________________________________"
sleep 600
done