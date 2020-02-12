#!/bin/bash

echo $ID > /root/kafka/data/zookeeper/myid
echo $hostname -> id.$ID -> $(hostname -I)
echo -e "\n172.19.0.10 node-1\n172.19.1.10 node-2\n172.19.2.10 node-3" >> /etc/hosts
sed "/127.0.0.1/c\127.0.0.1\tlocalhost\t$HOSTNAME\tnode-$ID" /etc/hosts
sed -i -e "s/^broker\.id.*/broker\.id=$ID/" -e "s/^advertised\.listeners.*/advertised.listeners=PLAINTEXT:\/\/node-$ID:9092/" /root/kafka/config/server.properties
/root/kafka/bin/zookeeper-server-start.sh /root/kafka/config/zookeeper.properties &
/root/kafka/bin/kafka-server-start.sh /root/kafka/config/server.properties
