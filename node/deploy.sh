#!/bin/bash

echo $ID > /root/kafka/data/zookeeper/myid
echo -e "\n172.19.0.10 node-1\n172.19.1.10 node-2\n172.19.2.10 node-3" >> /etc/hosts
sed "/127.0.0.1/c\127.0.0.1\tlocalhost\t$HOSTNAME\tnode-$ID" /etc/hosts
bash
/root/kafka/bin/zookeeper-server-start.sh /root/kafka/config/zookeeper.properties
